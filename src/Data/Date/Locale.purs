module Data.Date.Locale
  ( Locale()
  , dateTime
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

import Control.Monad.Eff (Eff())
import Data.Date
import Data.Enum (fromEnum, toEnum)
import Data.Function (Fn2(), runFn2, Fn7(), runFn7)
import Data.Int (Int())
import Data.Maybe (Maybe())
import Data.Maybe.Unsafe (fromJust)
import Data.Time

-- | The effect of reading the current system locale/timezone.
foreign import data Locale :: !

-- | Attempts to create a `Date` from date and time components based on the
-- | current machine’s locale. `Nothing` is returned if the resulting date is
-- | invalid.
dateTime :: forall e. Year -> Month -> DayOfMonth
         -> HourOfDay -> MinuteOfHour -> SecondOfMinute -> MillisecondOfSecond
         -> Eff (locale :: Locale | e) (Maybe Date)
dateTime y mo d h mi s ms =
  fromJSDate <$> runFn7 jsDateFromValues y (fromEnum mo) d h mi s ms

-- | Attempts to create a `Date` from date components based on the current
-- | machine’s locale. `Nothing` is returned if the resulting date is invalid.
date :: forall e. Year -> Month -> DayOfMonth -> Eff (locale :: Locale | e) (Maybe Date)
date y m d = dateTime y m d (HourOfDay zero) (MinuteOfHour zero) (SecondOfMinute zero) (MillisecondOfSecond zero)

-- | Gets the year component for a date based on the current machine’s locale.
year :: Date -> Year
year d = runFn2 dateMethod "getUTCFullYear" d

-- | Gets the month component for a date based on the current machine’s locale.
month :: Date -> Month
month d = fromJust (toEnum (runFn2 dateMethod "getUTCMonth" d))

-- | Gets the day-of-month value for a date based on the current machine’s
-- | locale.
dayOfMonth :: Date -> DayOfMonth
dayOfMonth d = runFn2 dateMethod "getUTCDate" d

-- | Gets the day-of-week value for a date based on the current machine’s
-- | locale.
dayOfWeek :: Date -> DayOfWeek
dayOfWeek d = fromJust (toEnum (runFn2 dateMethod "getUTCDay"d ))

-- | Gets the hour-of-day value for a date based on the current machine’s
-- | locale.
hourOfDay :: Date -> HourOfDay
hourOfDay d = runFn2 dateMethod "getUTCHours" d

-- | Gets the minute-of-hour value for a date based on the current machine’s
-- | locale.
minuteOfHour :: Date -> MinuteOfHour
minuteOfHour d = runFn2 dateMethod "getUTCMinutes" d

-- | Get the second-of-minute value for a date based on the current machine’s
-- | locale.
secondOfMinute :: Date -> SecondOfMinute
secondOfMinute d = runFn2 dateMethod "getUTCSeconds" d

-- | Get the millisecond-of-second value for a date based on the current
-- | machine’s locale.
millisecondOfSecond :: Date -> MillisecondOfSecond
millisecondOfSecond d = runFn2 dateMethod "getUTCMilliseconds" d

foreign import dateMethod
  """
  function dateMethod(method, date) {
    return date[method]();
  }
  """ :: forall a. Fn2 String Date a

foreign import jsDateFromValues
  """
  function jsDateFromValues(y, mo, d, h, mi, s, ms) {
    return function () {
      return new Date(y, mo, d, h, mi, s, ms);
    };
  }
  """ :: forall e. Fn7 Year Number DayOfMonth HourOfDay MinuteOfHour SecondOfMinute MillisecondOfSecond (Eff (locale :: Locale | e) JSDate)
