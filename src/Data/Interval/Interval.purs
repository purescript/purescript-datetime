module Data.Interval
  ( Duration
  , Interval
  , RecurringInterval
  , year
  , month
  , week
  , day
  , hours
  , minutes
  , seconds
  , milliseconds
  , mkDuration
  , DurationView
  ) where

import Prelude
import Data.Monoid (class Monoid, mempty)

import Data.Maybe (Maybe)
import Data.List (List(..), (:), filter)
import Data.Tuple (Tuple(..))


data RecurringInterval a = RecurringInterval (Maybe Int) (Interval a)

data Interval a
  = StartEnd      a a
  | StartDuration Duration a
  | DurationEnd   a Duration
  | JustDuration  Duration

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

-- TODO maybe we should implement custom Eq and Ord
derive instance eqDuration ∷ Eq Duration

data DurationComponent = Year | Month | Day | Hours | Minutes | Seconds | Milliseconds
derive instance eqDurationComponent ∷ Eq DurationComponent
derive instance ordDurationComponent ∷ Ord DurationComponent

appendComponents ∷ DurationIn → DurationIn → DurationIn
appendComponents Nil x = x
appendComponents x Nil = x
appendComponents ass@(a@(Tuple aC aV) : as) bss@(b@(Tuple bC bV) : bs) =
  if aC == bC then Tuple aC (aV + bV) : appendComponents as bs
  else if aC >  bC then a : appendComponents as bss
  else b : appendComponents ass bs

-- appendComponents ass@(a:as) bss@(b:bs) = case a, b of
--   Tuple xC xV, Tuple yC yV | xC == yC → Tuple xC (xV + yV) : appendComponents as bs
--   Tuple xC xV, Tuple yC yV | xC >  yC → a : appendComponents as bss
--   Tuple xC xV, Tuple yC yV | xC <  yC → b : appendComponents ass bs

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
