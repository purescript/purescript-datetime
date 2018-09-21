module Data.Date
  ( Date
  , canonicalDate
  , exactDate
  , year
  , month
  , day
  , weekday
  , diff
  , isLeapYear
  , lastDayOfMonth
  , adjust
  , module Data.Date.Component
  ) where

import Prelude

import Data.Date.Component (Day, Month(..), Weekday(..), Year)
import Data.Enum (class Enum, toEnum, fromEnum, succ, pred)
import Data.Function.Uncurried (Fn3, runFn3, Fn4, runFn4, Fn6, runFn6)
import Data.Int (fromNumber)
import Data.Maybe (Maybe(..), fromJust, fromMaybe, isNothing)
import Data.Time.Duration (class Duration, Days(..), Milliseconds, toDuration)
import Partial.Unsafe (unsafePartial)

-- | A date value in the Gregorian calendar.
data Date = Date Year Month Day

-- | Constructs a date from year, month, and day components. The resulting date
-- | components may not be identical to the input values, as the date will be
-- | canonicalised according to the Gregorian calendar. For example, date
-- | values for the invalid date 2016-02-31 will be corrected to 2016-03-02.
canonicalDate :: Year -> Month -> Day -> Date
canonicalDate y m d = runFn4 canonicalDateImpl mkDate y (fromEnum m) d
  where
  mkDate :: Year -> Int -> Day -> Date
  mkDate = unsafePartial \y' m' d' -> Date y' (fromJust (toEnum m')) d'

-- | Constructs a date from year, month, and day components. The result will be
-- | `Nothing` if the provided values result in an invalid date.
exactDate :: Year -> Month -> Day -> Maybe Date
exactDate y m d =
  let dt = Date y m d
  in if canonicalDate y m d == dt then Just dt else Nothing

derive instance eqDate :: Eq Date
derive instance ordDate :: Ord Date

instance boundedDate :: Bounded Date where
  bottom = Date bottom bottom bottom
  top = Date top top top

instance showDate :: Show Date where
  show (Date y m d) = "(Date " <> show y <> " " <> show m <> " " <> show d <> ")"

instance enumDate :: Enum Date where
  succ (Date y m d) = Date <$> y' <*> pure m' <*> d'
    where
      d' = if isNothing sd then toEnum 1 else sd
      m' = if isNothing sd then fromMaybe January sm else m
      y' = if isNothing sd && isNothing sm then succ y else Just y
      sd = let v = succ d in if v > Just l then Nothing else v
      sm = succ m
      l = lastDayOfMonth y m
  pred (Date y m d) = Date <$> y' <*> pure m' <*> d'
    where
      d' = if isNothing pd then Just l else pd
      m' = if isNothing pd then fromMaybe December pm else m
      y' = if isNothing pd && isNothing pm then pred y else Just y
      pd = pred d
      pm = pred m
      l = lastDayOfMonth y m'

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
weekday = unsafePartial \(Date y m d) ->
  let n = runFn3 calcWeekday y (fromEnum m) d
  in if n == 0 then fromJust (toEnum 7) else fromJust (toEnum n)

-- | Adjusts a date with a Duration in days. The day duration is
-- | converted to an Int using fromNumber.
adjust :: Days -> Date -> Maybe Date
adjust (Days n) date =
  fromNumber n >>= \i -> (if i < 0 then adjustDown else adjustUp) i date
  where
    adjustUp :: Int -> Date -> Maybe Date
    adjustUp 0 dt = Just dt
    adjustUp i (Date y m d) = adjustUp i' =<< Date <$> y' <*> pure m' <*> d'
      where
        i' = if isNothing md then j - l - 1 else 0
        d' = if isNothing md then toEnum 1 else md
        m' = if isNothing md then fromMaybe January sm else m
        y' = if isNothing md && isNothing sm then succ y else Just y
        j   = i + fromEnum d
        md = if j > l then Nothing else toEnum j
        sm = succ m
        l  = fromEnum $ lastDayOfMonth y m

    adjustDown :: Int -> Date -> Maybe Date
    adjustDown 0 dt = Just dt
    adjustDown i (Date y m d) = adjustDown i' =<< Date <$> y' <*> pure m' <*> d'
      where
        i' = if isNothing md then j else 0
        d' = if isNothing md then Just l else md
        m' = if isNothing md then fromMaybe December pm else m
        y' = if isNothing md && isNothing pm then pred y else Just y
        j   = i + fromEnum d
        md = if j < 1 then Nothing else toEnum j
        pm = pred m
        l  = lastDayOfMonth y m'

-- | Calculates the difference between two dates, returning the result as a
-- | duration.
diff :: forall d. Duration d => Date -> Date -> d
diff (Date y1 m1 d1) (Date y2 m2 d2) =
  toDuration $ runFn6 calcDiff y1 (fromEnum m1) d1 y2 (fromEnum m2) d2

-- | Checks whether a year is a leap year according to the proleptic Gregorian
-- | calendar.
isLeapYear :: Year -> Boolean
isLeapYear y = (mod y' 4 == 0) && ((mod y' 400 == 0) || not (mod y' 100 == 0))
  where
  y' = fromEnum y

-- | Get the final day of a month and year, accounting for leap years.
lastDayOfMonth :: Year -> Month -> Day
lastDayOfMonth y m = case m of
  January -> unsafeDay 31
  February
    | isLeapYear y -> unsafeDay 29
    | otherwise -> unsafeDay 28
  March -> unsafeDay 31
  April -> unsafeDay 30
  May -> unsafeDay 31
  June -> unsafeDay 30
  July -> unsafeDay 31
  August -> unsafeDay 31
  September -> unsafeDay 30
  October -> unsafeDay 31
  November -> unsafeDay 30
  December -> unsafeDay 31
  where
    unsafeDay = unsafePartial fromJust <<< toEnum

-- TODO: these could (and probably should) be implemented in PS
foreign import canonicalDateImpl :: Fn4 (Year -> Int -> Day -> Date) Year Int Day Date
foreign import calcWeekday :: Fn3 Year Int Day Int
foreign import calcDiff :: Fn6 Year Int Day Year Int Day Milliseconds
