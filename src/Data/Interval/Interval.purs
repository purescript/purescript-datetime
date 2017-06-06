module Data.Interval
  ( Interval(..)
  , RecurringInterval(..)
  , IsoDuration
  , Duration(..)
  , DurationComponent(..)
  , unIsoDuration
  , mkIsoDuration
  , isValidIsoDuration
  , year
  , month
  , week
  , day
  , hour
  , minute
  , second
  , millisecond
  ) where

import Prelude
import Control.Extend (class Extend, (=>>), extend)
import Data.Foldable (class Foldable, foldl, foldr, fold, foldMap, foldrDefault, foldMapDefaultL)
import Data.Bifoldable (class Bifoldable, bifoldl, bifoldr, bifoldrDefault, bifoldMapDefaultL)
import Data.Bifunctor (class Bifunctor, bimap)
import Data.Bitraversable (class Bitraversable, bitraverse, bisequenceDefault)
import Data.List ((:))
import Data.Maybe (Maybe(..))
import Data.Map as Map
import Data.Monoid (class Monoid, mempty)
import Data.Monoid.Conj (Conj(..))
import Data.Monoid.Additive (Additive(..))
import Data.Traversable (class Traversable, traverse, sequenceDefault)
import Data.Tuple (Tuple(..), snd)
import Data.Newtype (class Newtype)
import Control.Comonad (extract)
import Math as Math

-- TODO read this lib for some helper function inspiration around intervals/durations
-- https://github.com/arnau/ISO8601/blob/master/spec/iso8601/duration_spec.rb
data RecurringInterval d a = RecurringInterval (Maybe Int) (Interval d a)

derive instance eqRecurringInterval ∷ (Eq d, Eq a) => Eq (RecurringInterval d a)
instance showRecurringInterval ∷ (Show d, Show a) => Show (RecurringInterval d a) where
  show (RecurringInterval x y) = "(RecurringInterval " <> show x <> " " <> show y <> ")"

interval ∷ ∀ d a . RecurringInterval d a → Interval d a
interval (RecurringInterval _ i) = i

over ∷ ∀ f d a d' a'. Functor f => (Interval d a → f (Interval d' a')) → RecurringInterval d a → f (RecurringInterval d' a')
over f (RecurringInterval n i) = map (RecurringInterval n) (f i)

instance functorRecurringInterval ∷ Functor (RecurringInterval d) where
  map f (RecurringInterval n i) = (RecurringInterval n (map f i))

instance bifunctorRecurringInterval ∷ Bifunctor RecurringInterval where
  bimap f g (RecurringInterval n i) = RecurringInterval n $ bimap f g i

instance foldableRecurringInterval ∷ Foldable (RecurringInterval d) where
  foldl f i = foldl f i <<< interval
  foldr f i = foldr f i <<< interval
  foldMap = foldMapDefaultL

instance bifoldableRecurringInterval ∷ Bifoldable RecurringInterval where
  bifoldl f g i = bifoldl f g i <<< interval
  bifoldr f g i = bifoldr f g i <<< interval
  bifoldMap = bifoldMapDefaultL

instance traversableRecurringInterval ∷ Traversable (RecurringInterval d) where
  traverse f i = (traverse f) `over` i
  sequence = sequenceDefault

instance bitraversableRecurringInterval ∷ Bitraversable RecurringInterval where
  bitraverse l r i = (bitraverse l r) `over` i
  bisequence = bisequenceDefault

instance extendRecurringInterval ∷ Extend (RecurringInterval d) where
  extend f a@(RecurringInterval n i) = RecurringInterval n (extend (const $ f a) i )

data Interval d a
  = StartEnd      a a
  | DurationEnd   d a
  | StartDuration a d
  | JustDuration  d

derive instance eqInterval ∷ (Eq d, Eq a) => Eq (Interval d a)
instance showInterval ∷ (Show d, Show a) => Show (Interval d a) where
  show (StartEnd x y) = "(StartEnd " <> show x <> " " <> show y <> ")"
  show (DurationEnd d x) = "(DurationEnd " <> show d <> " " <> show x <> ")"
  show (StartDuration x d) = "(StartDuration " <> show x <> " " <> show d <> ")"
  show (JustDuration d) = "(JustDuration " <> show d <> ")"

instance functorInterval ∷ Functor (Interval d) where
  map = bimap id

instance bifunctorInterval ∷ Bifunctor Interval where
  bimap _ f (StartEnd x y) = StartEnd (f x) (f y )
  bimap g f (DurationEnd d x) = DurationEnd (g d) (f x )
  bimap g f (StartDuration x d) = StartDuration (f x) (g d)
  bimap g _ (JustDuration d) = JustDuration (g d)

instance foldableInterval ∷ Foldable (Interval d) where
  foldl f z (StartEnd x y) = (z `f` x) `f` y
  foldl f z (DurationEnd d x) = z `f` x
  foldl f z (StartDuration x d) = z `f` x
  foldl _ z _  = z
  foldr x = foldrDefault x
  foldMap = foldMapDefaultL

instance bifoldableInterval ∷ Bifoldable Interval where
  bifoldl _ f z (StartEnd x y) = (z `f` x) `f` y
  bifoldl g f z (DurationEnd d x) = (z `g` d) `f` x
  bifoldl g f z (StartDuration x d) = (z `g` d) `f` x
  bifoldl g _ z (JustDuration d)  = z `g` d
  bifoldr x = bifoldrDefault x
  bifoldMap = bifoldMapDefaultL

instance traversableInterval ∷ Traversable (Interval d) where
  traverse f (StartEnd x y) = StartEnd <$> f x  <*> f y
  traverse f (DurationEnd d x) = f x <#> DurationEnd d
  traverse f (StartDuration x d) = f x <#> (_ `StartDuration` d)
  traverse _ (JustDuration d)  = pure (JustDuration d)
  sequence = sequenceDefault

instance bitraversableInterval ∷ Bitraversable Interval where
  bitraverse _ r (StartEnd x y) = StartEnd <$> r x <*> r y
  bitraverse l r (DurationEnd d x) = DurationEnd <$> l d <*> r x
  bitraverse l r (StartDuration x d) = StartDuration <$> r x <*> l d
  bitraverse l _ (JustDuration d)  = JustDuration <$> l d
  bisequence = bisequenceDefault

instance extendInterval ∷ Extend (Interval d) where
  extend f a@(StartEnd x y) = StartEnd (f a) (f a )
  extend f a@(DurationEnd d x) = DurationEnd d (f a )
  extend f a@(StartDuration x d) = StartDuration (f a) d
  extend f (JustDuration d) = JustDuration d


mkIsoDuration ∷ Duration → Maybe IsoDuration
mkIsoDuration d | isValidIsoDuration d = Just $ IsoDuration d
mkIsoDuration _ = Nothing

isFractional ∷ Number → Boolean
isFractional a = Math.floor a /= a

isValidIsoDuration ∷ Duration → Boolean
isValidIsoDuration (Duration m) = (not $ Map.isEmpty m) && (hasValidFractionalUse m)
  where
    -- allow only last number to be fractional
    hasValidFractionalUse = Map.toAscUnfoldable
      >>> (_ =>> (validateFractionalUse >>> Conj))
      >>> fold
      >>> extract
    validateFractionalUse = case _ of
      (Tuple _ n):as | isFractional n → foldMap (snd >>> Additive) as == mempty
      _ → true

unIsoDuration ∷ IsoDuration → Duration
unIsoDuration (IsoDuration a) = a

newtype IsoDuration = IsoDuration Duration
derive instance eqIsoDuration ∷ Eq IsoDuration
instance showIsoDuration ∷ Show IsoDuration where
  show (IsoDuration d)= "(IsoDuration " <> show d <> ")"


newtype Duration = Duration (Map.Map DurationComponent Number)
-- TODO `day 1 == hour 24`
derive instance eqDuration ∷ Eq Duration
derive instance newtypeDuration ∷ Newtype Duration _

instance showDuration ∷ Show Duration where
  show (Duration d)= "(Duration " <> show d <> ")"

instance semigroupDuration ∷ Semigroup Duration where
  append (Duration a) (Duration b) = Duration $ Map.unionWith (+) a b

instance monoidDuration ∷ Monoid Duration where
  mempty = Duration mempty

data DurationComponent = Year | Month | Day | Hour | Minute | Second
derive instance eqDurationComponent ∷ Eq DurationComponent
derive instance ordDurationComponent ∷ Ord DurationComponent

instance showDurationComponent ∷ Show DurationComponent where
  show Year = "Year"
  show Month = "Month"
  show Day = "Day"
  show Hour = "Hour"
  show Minute = "Minute"
  show Second = "Second"


week ∷ Number → Duration
week = durationFromComponent Day <<< (_ * 7.0)

year ∷ Number → Duration
year = durationFromComponent Year

month ∷ Number → Duration
month = durationFromComponent Month

day ∷ Number → Duration
day = durationFromComponent Day

hour ∷ Number → Duration
hour = durationFromComponent Hour

minute ∷ Number → Duration
minute = durationFromComponent Minute

second ∷ Number → Duration
second = durationFromComponent Second

millisecond ∷ Number → Duration
millisecond = durationFromComponent Second <<< (_ / 1000.0)

durationFromComponent ∷ DurationComponent → Number → Duration
-- durationFromComponent _ 0.0 = mempty
durationFromComponent k v= Duration $ Map.singleton k v
