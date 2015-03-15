module Data.Date.UTC
  ( dateTime
  , date
  , year
  , month
  , day
  , dayOfWeek
  , hour
  , minute
  , second
  , millisecond
  ) where

import Data.Date
import Data.Enum (fromEnum, toEnum)
import Data.Function (Fn2(), runFn2, Fn7(), runFn7)
import Data.Maybe (Maybe())
import Data.Maybe.Unsafe (fromJust)
import Data.Time

dateTime :: Year -> Month -> Day
         -> Hours -> Minutes -> Seconds -> Milliseconds
         -> Maybe Date
dateTime y mo d h mi s ms =
  fromJSDate (runFn7 jsDateFromValues y (fromEnum mo) d h mi s ms)

date :: Year -> Month -> Day -> Maybe Date
date y m d = dateTime y m d zero zero zero zero

year :: Date -> Year
year d = runFn2 dateMethod "getUTCFullYear" d

month :: Date -> Month
month d = fromJust (toEnum (runFn2 dateMethod "getUTCMonth" d))

day :: Date -> Day
day d = runFn2 dateMethod "getUTCDate" d

dayOfWeek :: Date -> DayOfWeek
dayOfWeek d = fromJust (toEnum (runFn2 dateMethod "getUTCDay"d ))

hour :: Date -> Hours
hour d = runFn2 dateMethod "getUTCHours" d

minute :: Date -> Minutes
minute d = runFn2 dateMethod "getUTCMinutes" d

second :: Date -> Seconds
second d = runFn2 dateMethod "getUTCSeconds" d

millisecond :: Date -> Milliseconds
millisecond d = runFn2 dateMethod "getUTCMilliseconds" d

foreign import dateMethod
  """
  function dateMethod(method, date) {
    return date[method]();
  }
  """ :: forall a. Fn2 String Date a

foreign import jsDateFromValues
  """
  function jsDateFromValues(y, mo, d, h, mi, s, ms) {
    return Date.UTC(y, mo, d, h, mi, s, ms);
  }
  """ :: Fn7 Year Number Day Hours Minutes Seconds Milliseconds JSDate
