module Data.Interval
  ( Duration
  , Interval(..)
  , RecurringInterval(..)
  , DurationView
  , mkDuration
  , year
  , month
  , week
  , day
  , hours
  , minutes
  , seconds
  , milliseconds
  ) where

import Prelude

import Data.Foldable (class Foldable, foldrDefault, foldMapDefaultL)
import Data.Traversable (class Traversable, sequenceDefault)
import Data.Monoid (class Monoid, mempty)
import Control.Extend (class Extend)

import Data.Maybe (Maybe)
import Data.List (List(..), (:), filter)
import Data.Tuple (Tuple(..))


data RecurringInterval a = RecurringInterval (Maybe Int) (Interval a)

data Interval a
  = StartEnd      a a
  | DurationEnd   Duration a
  | StartDuration a Duration
  | JustDuration  Duration

instance showInterval ∷ (Show a) => Show (Interval a) where
  show (StartEnd x y) = "(StartEnd " <> show x <> " " <> show y <> ")"
  show (DurationEnd d x) = "(DurationEnd " <> show d <> " " <> show x <> ")"
  show (StartDuration x d) = "(StartDuration " <> show x <> " " <> show d <> ")"
  show (JustDuration d) = "(JustDuration " <> show d <> ")"

instance functorInterval ∷ Functor Interval where
  map f (StartEnd x y) = StartEnd (f x) (f y )
  map f (DurationEnd d x) = DurationEnd d (f x )
  map f (StartDuration x d) = StartDuration (f x) d
  map _ (JustDuration d) = JustDuration d

instance foldableInterval ∷ Foldable Interval where
  foldl f z (StartEnd x y) = (z `f` x) `f` y
  foldl f z (DurationEnd d x) = z `f` x
  foldl f z (StartDuration x d) = z `f` x
  foldl _ z _  = z
  foldr x = foldrDefault x
  foldMap = foldMapDefaultL

instance traversableInterval ∷ Traversable Interval where
  traverse f (StartEnd x y) = StartEnd <$> f x  <*> f y
  traverse f (DurationEnd d x) = f x <#> DurationEnd d
  traverse f (StartDuration x d) = f x <#> (_ `StartDuration` d)
  traverse _ (JustDuration d)  = pure (JustDuration d)
  sequence = sequenceDefault

instance extendInterval ∷ Extend Interval where
  extend f a@(StartEnd x y) = StartEnd (f a) (f a )
  extend f a@(DurationEnd d x) = DurationEnd d (f a )
  extend f a@(StartDuration x d) = StartDuration (f a) d
  extend f (JustDuration d) = JustDuration d

type DurationView =
  { year ∷ Number
  , month ∷ Number
  , day ∷ Number
  , hours ∷ Number
  , minutes ∷ Number
  , seconds ∷ Number
  , milliseconds ∷ Number
  }

mkDuration ∷ DurationView → Duration
mkDuration d = Duration $
  ( Tuple Year d.year
  : Tuple Month d.month
  : Tuple Day d.day
  : Tuple Hours d.hours
  : Tuple Minutes d.minutes
  : Tuple Seconds d.seconds
  : Tuple Milliseconds d.milliseconds
  : Nil
  ) # filter (\(Tuple _ v) → v /= 0.0)

data Duration = Duration DurationIn
type DurationIn = List (Tuple DurationComponent Number)

derive instance eqDuration ∷ Eq Duration
instance showDuration ∷ Show Duration where
  show (Duration d)= "(Duration " <> show d <> ")"


data DurationComponent = Year | Month | Day | Hours | Minutes | Seconds | Milliseconds

instance showDurationComponent ∷ Show DurationComponent where
  show Year = "Year"
  show Month = "Month"
  show Day = "Day"
  show Hours = "Hours"
  show Minutes = "Minutes"
  show Seconds = "Seconds"
  show Milliseconds= "Millisecond"

derive instance eqDurationComponent ∷ Eq DurationComponent
derive instance ordDurationComponent ∷ Ord DurationComponent

appendComponents ∷ DurationIn → DurationIn → DurationIn
appendComponents Nil x = x
appendComponents x Nil = x
appendComponents ass@(a:as) bss@(b:bs) = case a, b of
  Tuple aC aV, Tuple bC bV
    | aC >  bC → a : appendComponents as bss
    | aC <  bC → b : appendComponents ass bs
    | otherwise → Tuple aC (aV + bV) : appendComponents as bs

instance semigroupDuration ∷ Semigroup Duration where
  append (Duration a) (Duration b) = Duration (appendComponents a b)

instance monoidDuration ∷ Monoid Duration where
  mempty = Duration mempty


week ∷ Number → Duration
week = Duration <<< pure <<< Tuple Day <<< (_ * 7.0)

year ∷ Number → Duration
year = Duration <<< pure <<< Tuple Year

month ∷ Number → Duration
month = Duration <<< pure <<< Tuple Month

day ∷ Number → Duration
day = Duration <<< pure <<< Tuple Day

hours ∷ Number → Duration
hours = Duration <<< pure <<< Tuple Hours

minutes ∷ Number → Duration
minutes = Duration <<< pure <<< Tuple Minutes

seconds ∷ Number → Duration
seconds = Duration <<< pure <<< Tuple Seconds

milliseconds ∷ Number → Duration
milliseconds = Duration <<< pure <<< Tuple Milliseconds
