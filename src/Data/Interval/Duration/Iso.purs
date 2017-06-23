module Data.Interval.Duration.Iso
  ( IsoDuration
  , unIsoDuration
  , mkIsoDuration
  , Error(..)
  , Errors
  ) where

import Prelude

import Data.Array (uncons)
import Data.Either (Either(..))
import Data.Foldable (fold, foldMap)
import Data.Interval.Duration (Duration(..), DurationComponent(..))
import Data.List (List(..), reverse, span, null)
import Data.Map as Map
import Data.Maybe (Maybe(..), isJust)
import Data.Monoid.Additive (Additive(..))
import Data.Newtype (unwrap)
import Data.NonEmpty (NonEmpty(..))
import Data.Tuple (Tuple(..), snd)
import Math as Math

newtype IsoDuration = IsoDuration Duration

derive instance eqIsoDuration :: Eq IsoDuration
derive instance ordIsoDuration :: Ord IsoDuration
instance showIsoDuration :: Show IsoDuration where
  show (IsoDuration d) = "(IsoDuration " <> show d <> ")"

type Errors = NonEmpty Array Error

data Error
  = IsEmpty
  | InvalidWeekComponentUsage
  | ContainsNegativeValue DurationComponent
  | InvalidFractionalUse DurationComponent

derive instance eqError :: Eq Error
derive instance ordError :: Ord Error
instance showError :: Show Error where
  show (IsEmpty) = "(IsEmpty)"
  show (InvalidWeekComponentUsage) = "(InvalidWeekComponentUsage)"
  show (ContainsNegativeValue c) = "(ContainsNegativeValue " <> show c <> ")"
  show (InvalidFractionalUse c) = "(InvalidFractionalUse " <> show c <> ")"

unIsoDuration :: IsoDuration -> Duration
unIsoDuration (IsoDuration a) = a

mkIsoDuration :: Duration -> Either Errors IsoDuration
mkIsoDuration d = case uncons (checkValidIsoDuration d) of
  Just {head, tail} -> Left (NonEmpty head tail)
  Nothing -> Right (IsoDuration d)

checkValidIsoDuration :: Duration -> Array Error
checkValidIsoDuration (Duration asMap) = check {asList, asMap}
  where
  asList = reverse (Map.toAscUnfoldable asMap)
  check = fold
    [ checkWeekUsage
    , checkEmptiness
    , checkFractionalUse
    , checkNegativeValues
    ]


type CheckEnv =
  { asList :: List (Tuple DurationComponent Number)
  , asMap :: Map.Map DurationComponent Number}

checkWeekUsage :: CheckEnv -> Array Error
checkWeekUsage {asMap} = if isJust (Map.lookup Week asMap) && Map.size asMap > 1
  then [InvalidWeekComponentUsage] else []

checkEmptiness :: CheckEnv -> Array Error
checkEmptiness {asList} = if null asList then [IsEmpty] else []

checkFractionalUse :: CheckEnv -> Array Error
checkFractionalUse {asList} = case _.rest (span (snd >>> not isFractional) asList) of
  Cons (Tuple c _) rest | checkRest rest -> [InvalidFractionalUse c]
  _ -> []
  where
  isFractional a = Math.floor a /= a
  checkRest rest = unwrap (foldMap (snd >>> Math.abs >>> Additive) rest) > 0.0

checkNegativeValues :: CheckEnv -> Array Error
checkNegativeValues {asList} = flip foldMap asList \(Tuple c num) ->
  if num >= 0.0 then [] else [ContainsNegativeValue c]
