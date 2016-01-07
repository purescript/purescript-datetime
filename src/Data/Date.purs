module Data.Date
  ( JSDate()
  , Date()
  , fromJSDate
  , toJSDate
  , fromEpochMilliseconds
  , toEpochMilliseconds
  , fromString
  , fromStringStrict
  , Now()
  , now
  , nowEpochMilliseconds
  , LocaleOffset(..)
  , timezoneOffset
  , Year(..)
  , Month(..)
  , DayOfMonth(..)
  , DayOfWeek(..)
  ) where

import Prelude

import Control.Monad.Eff
import Data.Enum (Enum, Cardinality(..), fromEnum, defaultSucc, defaultPred)
import Data.Function (on, Fn2(), runFn2, Fn3(), runFn3)
import Data.Maybe (Maybe(..))
import Data.Time

-- | A native JavaScript `Date` object.
foreign import data JSDate :: *

-- | A combined date/time value. `Date`s cannot be constructed directly to
-- | ensure they are not the `Invalid Date` value, and instead must be created
-- | via `fromJSDate`, `fromEpochMilliseconds`, `fromString`, etc. or the `date`
-- | and `dateTime` functions in the `Data.Date.Locale` and `Data.Date.UTC`
-- | modules.
newtype Date = DateTime JSDate

instance eqDate :: Eq Date where
  eq = eq `on` toEpochMilliseconds

instance ordDate :: Ord Date where
  compare = compare `on` toEpochMilliseconds

instance showDate :: Show Date where
  show d = "(fromEpochMilliseconds " ++ show (toEpochMilliseconds d) ++ ")"

-- | Attempts to create a `Date` from a `JSDate`. If the `JSDate` is an invalid
-- | date `Nothing` is returned.
fromJSDate :: JSDate -> Maybe Date
fromJSDate d =
  if Global.isNaN (runFn2 jsDateMethod "getTime" d)
  then Nothing
  else Just (DateTime d)

-- | Extracts a `JSDate` from a `Date`.
toJSDate :: Date -> JSDate
toJSDate (DateTime d) = d

-- | Creates a `Date` value from a number of milliseconds elapsed since 1st
-- | January 1970 00:00:00 UTC.
fromEpochMilliseconds :: Milliseconds -> Maybe Date
fromEpochMilliseconds = fromJSDate <<< jsDateConstructor

-- | Gets the number of milliseconds elapsed since 1st January 1970 00:00:00
-- | UTC for a `Date`.
toEpochMilliseconds :: Date -> Milliseconds
toEpochMilliseconds (DateTime d) = runFn2 jsDateMethod "getTime" d

-- | Attempts to construct a date from a string value using JavaScript’s
-- | [Date.parse() method](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/parse).
-- | `Nothing` is returned if the parse fails or the resulting date is invalid.
fromString :: String -> Maybe Date
fromString = fromJSDate <<< jsDateConstructor

-- | Attempts to construct a date from a simplified extended ISO 8601 format
-- | (`YYYY-MM-DDTHH:mm:ss.sssZ`). `Nothing` is returned if the format is not
-- | an exact match or the resulting date is invalid.
fromStringStrict :: String -> Maybe Date
fromStringStrict s = runFn3 strictJsDate Just Nothing s >>= fromJSDate

-- | Effect type for when accessing the current date/time.
foreign import data Now :: !

-- | Gets a `Date` value for the current date/time according to the current
-- | machine’s local time.
now :: forall e. Eff (now :: Now | e) Date
now = nowImpl DateTime

-- | Gets the number of milliseconds elapsed milliseconds since 1st January
-- | 1970 00:00:00 UTC according to the current machine’s local time
foreign import nowEpochMilliseconds :: forall e. Eff (now :: Now | e) Milliseconds

-- | A timezone locale offset, measured in minutes.
newtype LocaleOffset = LocaleOffset Minutes

-- | Get the locale time offset for a `Date`.
timezoneOffset :: Date -> LocaleOffset
timezoneOffset (DateTime d) = runFn2 jsDateMethod "getTimezoneOffset" d

-- | A year date component value.
newtype Year = Year Int

instance eqYear :: Eq Year where
  eq (Year x) (Year y) = x == y

instance ordYear :: Ord Year where
  compare (Year x) (Year y) = compare x y

instance semiringYear :: Semiring Year where
  add (Year x) (Year y) = Year (x + y)
  mul (Year x) (Year y) = Year (x * y)
  zero = Year zero
  one = Year one

instance ringYear :: Ring Year where
  sub (Year x) (Year y) = Year (x - y)

instance showYear :: Show Year where
  show (Year n) = "(Year " ++ show n ++ ")"

-- | A month date component value.
data Month
  = January
  | February
  | March
  | April
  | May
  | June
  | July
  | August
  | September
  | October
  | November
  | December

instance eqMonth :: Eq Month where
  eq January   January   = true
  eq February  February  = true
  eq March     March     = true
  eq April     April     = true
  eq May       May       = true
  eq June      June      = true
  eq July      July      = true
  eq August    August    = true
  eq September September = true
  eq October   October   = true
  eq November  November  = true
  eq December  December  = true
  eq _         _         = false

instance ordMonth :: Ord Month where
  compare = compare `on` fromEnum

instance boundedMonth :: Bounded Month where
  bottom = January
  top = December

instance boundedOrdMonth :: BoundedOrd Month

instance showMonth :: Show Month where
  show January   = "January"
  show February  = "February"
  show March     = "March"
  show April     = "April"
  show May       = "May"
  show June      = "June"
  show July      = "July"
  show August    = "August"
  show September = "September"
  show October   = "October"
  show November  = "November"
  show December  = "December"

instance enumMonth :: Enum Month where
  cardinality = Cardinality 12
  succ = defaultSucc monthToEnum monthFromEnum
  pred = defaultPred monthToEnum monthFromEnum
  toEnum = monthToEnum
  fromEnum = monthFromEnum

monthToEnum :: Int -> Maybe Month
monthToEnum 0  = Just January
monthToEnum 1  = Just February
monthToEnum 2  = Just March
monthToEnum 3  = Just April
monthToEnum 4  = Just May
monthToEnum 5  = Just June
monthToEnum 6  = Just July
monthToEnum 7  = Just August
monthToEnum 8  = Just September
monthToEnum 9  = Just October
monthToEnum 10 = Just November
monthToEnum 11 = Just December
monthToEnum _  = Nothing

monthFromEnum :: Month -> Int
monthFromEnum January   = 0
monthFromEnum February  = 1
monthFromEnum March     = 2
monthFromEnum April     = 3
monthFromEnum May       = 4
monthFromEnum June      = 5
monthFromEnum July      = 6
monthFromEnum August    = 7
monthFromEnum September = 8
monthFromEnum October   = 9
monthFromEnum November  = 10
monthFromEnum December  = 11

-- | A day-of-month date component value.
newtype DayOfMonth = DayOfMonth Int

instance eqDayOfMonth :: Eq DayOfMonth where
  eq (DayOfMonth x) (DayOfMonth y) = x == y

instance ordDayOfMonth :: Ord DayOfMonth where
  compare (DayOfMonth x) (DayOfMonth y) = compare x y

instance showDayOfMonth :: Show DayOfMonth where
  show (DayOfMonth day) = "(DayOfMonth " ++ show day ++ ")"

-- | A day-of-week date component value.
data DayOfWeek
  = Sunday
  | Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday

instance eqDayOfWeek :: Eq DayOfWeek where
  eq Sunday    Sunday    = true
  eq Monday    Monday    = true
  eq Tuesday   Tuesday   = true
  eq Wednesday Wednesday = true
  eq Thursday  Thursday  = true
  eq Friday    Friday    = true
  eq Saturday  Saturday  = true
  eq _         _         = false

instance ordDayOfWeek :: Ord DayOfWeek where
  compare = compare `on` fromEnum

instance boundedDayOfWeek :: Bounded DayOfWeek where
  bottom = Sunday
  top = Saturday

instance boundedOrdDayOfWeek :: BoundedOrd DayOfWeek

instance showDayOfWeek :: Show DayOfWeek where
  show Sunday    = "Sunday"
  show Monday    = "Monday"
  show Tuesday   = "Tuesday"
  show Wednesday = "Wednesday"
  show Thursday  = "Thursday"
  show Friday    = "Friday"
  show Saturday  = "Saturday"

instance enumDayOfWeek :: Enum DayOfWeek where
  cardinality = Cardinality 7
  succ = defaultSucc dayOfWeekToEnum dayOfWeekFromEnum
  pred = defaultPred dayOfWeekToEnum dayOfWeekFromEnum
  toEnum = dayOfWeekToEnum
  fromEnum = dayOfWeekFromEnum

dayOfWeekToEnum :: Int -> Maybe DayOfWeek
dayOfWeekToEnum 0 = Just Sunday
dayOfWeekToEnum 1 = Just Monday
dayOfWeekToEnum 2 = Just Tuesday
dayOfWeekToEnum 3 = Just Wednesday
dayOfWeekToEnum 4 = Just Thursday
dayOfWeekToEnum 5 = Just Friday
dayOfWeekToEnum 6 = Just Saturday
dayOfWeekToEnum _ = Nothing

dayOfWeekFromEnum :: DayOfWeek -> Int
dayOfWeekFromEnum Sunday    = 0
dayOfWeekFromEnum Monday    = 1
dayOfWeekFromEnum Tuesday   = 2
dayOfWeekFromEnum Wednesday = 3
dayOfWeekFromEnum Thursday  = 4
dayOfWeekFromEnum Friday    = 5
dayOfWeekFromEnum Saturday  = 6

foreign import nowImpl :: forall e. (JSDate -> Date) -> Eff (now :: Now | e) Date

foreign import jsDateConstructor :: forall a. a -> JSDate

foreign import jsDateMethod :: forall a. Fn2 String JSDate a

foreign import strictJsDate :: Fn3 (forall a. a -> Maybe a) (forall a. Maybe a) String (Maybe JSDate)
