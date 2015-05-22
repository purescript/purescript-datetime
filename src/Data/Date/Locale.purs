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
  , toLocaleString
  , toLocaleTimeString
  , toLocaleDateString
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
year :: forall e. Date -> Eff (locale :: Locale | e) Year
year d = runFn2 dateMethod "getFullYear" d

-- | Gets the month component for a date based on the current machine’s locale.
month :: forall e. Date -> Eff (locale :: Locale | e) Month
month d = fromJust <<< toEnum <$> runFn2 dateMethod "getMonth" d

-- | Gets the day-of-month value for a date based on the current machine’s
-- | locale.
dayOfMonth :: forall e. Date -> Eff (locale :: Locale | e) DayOfMonth
dayOfMonth d = runFn2 dateMethod "getDate" d

-- | Gets the day-of-week value for a date based on the current machine’s
-- | locale.
dayOfWeek :: forall e. Date -> Eff (locale :: Locale | e) DayOfWeek
dayOfWeek d = fromJust <<< toEnum <$> runFn2 dateMethod "getDay" d

-- | Gets the hour-of-day value for a date based on the current machine’s
-- | locale.
hourOfDay :: forall e. Date -> Eff (locale :: Locale | e) HourOfDay
hourOfDay d = runFn2 dateMethod "getHours" d

-- | Gets the minute-of-hour value for a date based on the current machine’s
-- | locale.
minuteOfHour :: forall e. Date -> Eff (locale :: Locale | e) MinuteOfHour
minuteOfHour d = runFn2 dateMethod "getMinutes" d

-- | Get the second-of-minute value for a date based on the current machine’s
-- | locale.
secondOfMinute :: forall e. Date -> Eff (locale :: Locale | e) SecondOfMinute
secondOfMinute d = runFn2 dateMethod "getSeconds" d

-- | Get the millisecond-of-second value for a date based on the current
-- | machine’s locale.
millisecondOfSecond :: forall e. Date -> Eff (locale :: Locale | e) MillisecondOfSecond
millisecondOfSecond d = runFn2 dateMethod "getMilliseconds" d

-- | Format a date as a human-readable string (including the date and the
-- | time), based on the current machine's locale. Example output:
-- | "Fri May 22 2015 19:45:07 GMT+0100 (BST)", although bear in mind that this
-- | can vary significantly across platforms.
toLocaleString :: forall e. Date -> Eff (locale :: Locale | e) String
toLocaleString d = runFn2 dateMethod "toLocaleString" d

-- | Format a time as a human-readable string, based on the current machine's
-- | locale. Example output: "19:45:07", although bear in mind that this
-- | can vary significantly across platforms.
toLocaleTimeString :: forall e. Date -> Eff (locale :: Locale | e) String
toLocaleTimeString d = runFn2 dateMethod "toLocaleTimeString" d

-- | Format a date as a human-readable string, based on the current machine's
-- | locale. Example output: "Friday, May 22, 2015", although bear in mind that
-- | this can vary significantly across platforms.
toLocaleDateString :: forall e. Date -> Eff (locale :: Locale | e) String
toLocaleDateString d = runFn2 dateMethod "toLocaleDateString" d

foreign import dateMethod
  """
  function dateMethod(method, date) {
    return function () {
      return date[method]();
    };
  }
  """ :: forall e a. Fn2 String Date (Eff (locale :: Locale | e) a)

foreign import jsDateFromValues
  """
  function jsDateFromValues(y, mo, d, h, mi, s, ms) {
    return function () {
      return new Date(y, mo, d, h, mi, s, ms);
    };
  }
  """ :: forall e. Fn7 Year Number DayOfMonth HourOfDay MinuteOfHour SecondOfMinute MillisecondOfSecond (Eff (locale :: Locale | e) JSDate)
