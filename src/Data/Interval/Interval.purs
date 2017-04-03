module Data.Interval
  ( Duration
  , Interval
  , RecurringInterval
  ) where

import Prelude

import Data.Date as Date
import Data.Inteval.Duration as Duration
import Data.Time as Time

data Interval a
  = StartEnd      a a
  | StartDuration Duration a
  | DurationEnd   a Duration
  | JustDuration  Duration

data RecurringInterval a = RecurringInterval (Maybe Int) (Interval a)
data Duration
  = DurationWeek Week
  | DurationDateTime
    { year :: Year
    , month :: Month
    , day :: Day
    , week :: Week
    , day :: Day
    , hours :: Hours
    , minutes :: Minutes
    , seconds :: Seconds
    , milliseconds :: Milliseconds
    }

data Year = Int
data Month = Int
data Day = Int
data Week = Int
data Day = Int
data Hours = Int
data Minutes = Int
data Seconds = Int
data Milliseconds = Int
