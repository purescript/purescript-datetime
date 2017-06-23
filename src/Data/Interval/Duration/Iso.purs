module Data.Interval.Duration.Iso
  ( IsoDuration
  , unIsoDuration
  , mkIsoDuration
  , isValidIsoDuration
  ) where

import Prelude
import Control.Extend ((=>>))
import Data.Foldable (fold, foldMap)
import Data.Interval.Duration (Duration(..))
import Data.List (List, (:))
import Data.Maybe (Maybe(..))
import Data.Map as Map
import Data.Monoid (mempty)
import Data.Monoid.Conj (Conj(..))
import Data.Monoid.Additive (Additive(..))
import Data.Tuple (Tuple(..), snd)
import Control.Comonad (extract)
import Math as Math

newtype IsoDuration = IsoDuration Duration

derive instance eqIsoDuration :: Eq IsoDuration
derive instance ordIsoDuration :: Ord IsoDuration
instance showIsoDuration :: Show IsoDuration where
  show (IsoDuration d) = "(IsoDuration " <> show d <> ")"


unIsoDuration :: IsoDuration -> Duration
unIsoDuration (IsoDuration a) = a

mkIsoDuration :: Duration -> Maybe IsoDuration
mkIsoDuration d | isValidIsoDuration d = Just (IsoDuration d)
mkIsoDuration _ = Nothing

-- allow only positive numbers
-- allow only last number to be fractional
isValidIsoDuration :: Duration -> Boolean
isValidIsoDuration (Duration m) = not Map.isEmpty m && validNumberUsage m
  where
  isFractional :: Number -> Boolean
  isFractional a = Math.floor a /= a

  validNumberUsage :: forall a. Map.Map a Number -> Boolean
  validNumberUsage = Map.toAscUnfoldable
    >>> (\vals -> fold (vals =>> hasValidFractionalUse) <> hasOnlyPositiveNums vals)
    >>> extract

  hasValidFractionalUse :: forall a. List (Tuple a Number) -> Conj Boolean
  hasValidFractionalUse vals = Conj case vals of
    (Tuple _ n):as | isFractional n -> foldMap (snd >>> Additive) as == mempty
    _ -> true

  hasOnlyPositiveNums :: forall a. List (Tuple a Number) -> Conj Boolean
  hasOnlyPositiveNums vals = foldMap (snd >>> (_ >= 0.0) >>> Conj) vals
