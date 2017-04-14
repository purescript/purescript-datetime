module Data.Date
  ( Date
  , adjust
  , canonicalDate
  , exactDate
  , year
  , month
  , day
  , weekday
  , diff
  , isLeapYear
  , lastDayOfMonth
  , module Data.Date.Component
  ) where

import Prelude

import Data.Date.Component (Day, Month(..), Weekday(..), Year)
import Data.DateTime.Internal as Internal
import Data.Enum (toEnum, fromEnum)
import Data.Generic (class Generic)
import Data.Maybe (Maybe(..), fromJust)
import Data.Time.Duration (class Duration, fromDuration, toDuration)

import Partial.Unsafe (unsafePartial)

-- | A date value in the Gregorian calendar.
data Date = Date Year Month Day

-- | Constructs a date from year, month, and day components. The resulting date
-- | components may not be identical to the input values, as the date will be
-- | canonicalised according to the Gregorian calendar. For example, date
-- | values for the invalid date 2016-02-31 will be corrected to 2016-03-02.
canonicalDate :: Year -> Month -> Day -> Date
canonicalDate y m = unsafeFromRecord <<< Internal.normalize <<< ymdToRecord y m

-- | Constructs a date from year, month, and day components. The result will be
-- | `Nothing` if the provided values result in an invalid date.
exactDate :: Year -> Month -> Day -> Maybe Date
exactDate y m d =
  let dt = Date y m d
  in if canonicalDate y m d == dt then Just dt else Nothing

derive instance eqDate :: Eq Date
derive instance ordDate :: Ord Date
derive instance genericDate :: Generic Date

instance boundedDate :: Bounded Date where
  bottom = Date bottom bottom bottom
  top = Date top top top

instance showDate :: Show Date where
  show (Date y m d) = "(Date " <> show y <> " " <> show m <> " " <> show d <> ")"

-- | The year component of a date value.
year :: Date -> Year
year (Date y _ _) = y

-- | The month component of a date value.
month :: Date -> Month
month (Date _ m _) = m

-- | The day component of a date value.
day :: Date -> Day
day (Date _ _ d) = d

-- | The weekday for a date value.
weekday :: Date -> Weekday
weekday = unsafePartial \d ->
  let n = Internal.weekday $ toRecord d
  in if n == 0 then fromJust (toEnum 7) else fromJust (toEnum n)

-- | Adjusts a date value with a duration offset. `Nothing` is returned
-- | if the resulting date would be outside of the range of valid dates.
adjust :: forall d. Duration d => d -> Date -> Maybe Date
adjust du d = join $
    fromRecord <$> Internal.adjust (fromDuration du) (toRecord d)

-- | Calculates the difference between two dates, returning the result as a
-- | duration.
diff :: forall d. Duration d => Date -> Date -> d
diff d1 d2 = toDuration $ Internal.diff (toRecord d1) (toRecord d2)

-- | Is this year a leap year according to the proleptic Gregorian calendar?
isLeapYear :: Year -> Boolean
isLeapYear y = (mod y' 4 == 0) && ((mod y' 400 == 0) || not (mod y' 100 == 0))
  where
  y' = fromEnum y

-- | Get the final day of a month and year, accounting for leap years
lastDayOfMonth :: Year -> Month -> Day
lastDayOfMonth y m = case m of
  January   -> unsafeDay 31
  February
    | isLeapYear y -> unsafeDay 29
    | otherwise    -> unsafeDay 28
  March     -> unsafeDay 31
  April     -> unsafeDay 30
  May       -> unsafeDay 31
  June      -> unsafeDay 30
  July      -> unsafeDay 31
  August    -> unsafeDay 31
  September -> unsafeDay 30
  October   -> unsafeDay 31
  November  -> unsafeDay 30
  December  -> unsafeDay 31
  where
    unsafeDay = unsafePartial fromJust <<< toEnum

fromRecord :: Internal.DateTimeRec -> Maybe Date
fromRecord {year: y, month: m, day: d} = Date <$> toEnum y <*> toEnum m <*> toEnum d

unsafeFromRecord :: Internal.DateTimeRec -> Date
unsafeFromRecord = unsafePartial fromJust <<< fromRecord

toRecord :: Date -> Internal.DateTimeRec
toRecord (Date y m d) = ymdToRecord y m d

ymdToRecord :: Year -> Month -> Day -> Internal.DateTimeRec
ymdToRecord y m d =
  { year: fromEnum y
  , month: fromEnum m
  , day: fromEnum d
  , hour: 0
  , minute: 0
  , second: 0
  , millisecond: 0
  }
