module Data.Date.UTC
  ( dateTime
  , date
  , year
  , month
  , dayOfMonth
  , dayOfWeek
  , hourOfDay
  , minuteOfHour
  , secondOfMinute
  , millisecondOfSecond
  ) where

import Data.Date
import Data.Enum (fromEnum, toEnum)
import Data.Function (Fn2(), runFn2, Fn7(), runFn7)
import Data.Maybe (Maybe())
import Data.Maybe.Unsafe (fromJust)
import Data.Time

import Prelude
  ( zero )

-- | Attempts to create a `Date` from UTC date and time components. `Nothing`
-- | is returned if the resulting date is invalid.
dateTime :: Year -> Month -> DayOfMonth
         -> HourOfDay -> MinuteOfHour -> SecondOfMinute -> MillisecondOfSecond
         -> Maybe Date
dateTime y mo d h mi s ms =
  fromJSDate (runFn7 jsDateFromValues y (fromEnum mo) d h mi s ms)

-- | Attempts to create a `Date` from UTC date components. `Nothing` is
-- | returned if the resulting date is invalid.
date :: Year -> Month -> DayOfMonth -> Maybe Date
date y m d = dateTime y m d (HourOfDay zero) (MinuteOfHour zero) (SecondOfMinute zero) (MillisecondOfSecond zero)

-- | Gets the UTC year component for a date.
year :: Date -> Year
year d = runFn2 dateMethod "getUTCFullYear" d

-- | Gets the UTC month component for a date.
month :: Date -> Month
month d = fromJust (toEnum (runFn2 dateMethod "getUTCMonth" d))

-- | Gets the UTC day-of-month value for a date.
dayOfMonth :: Date -> DayOfMonth
dayOfMonth d = runFn2 dateMethod "getUTCDate" d

-- | Gets the UTC day-of-week value for a date.
dayOfWeek :: Date -> DayOfWeek
dayOfWeek d = fromJust (toEnum (runFn2 dateMethod "getUTCDay" d))

-- | Gets the UTC hour-of-day value for a date.
hourOfDay :: Date -> HourOfDay
hourOfDay d = runFn2 dateMethod "getUTCHours" d

-- | Gets the UTC minute-of-hour value for a date.
minuteOfHour :: Date -> MinuteOfHour
minuteOfHour d = runFn2 dateMethod "getUTCMinutes" d

-- | Get the UTC second-of-minute value for a date.
secondOfMinute :: Date -> SecondOfMinute
secondOfMinute d = runFn2 dateMethod "getUTCSeconds" d

-- | Get the UTC millisecond-of-second value for a date.
millisecondOfSecond :: Date -> MillisecondOfSecond
millisecondOfSecond d = runFn2 dateMethod "getUTCMilliseconds" d

foreign import dateMethod :: forall a. Fn2 String Date a

foreign import jsDateFromValues :: Fn7 Year Int DayOfMonth HourOfDay MinuteOfHour SecondOfMinute MillisecondOfSecond JSDate
