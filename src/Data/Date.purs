module Data.Date
  ( Date(..)
  , JSDate()
  , fromJSDate
  , toJSDate
  , fromEpochMilliseconds
  , toEpochMilliseconds
  , fromString
  , fromStringStrict
  , timezoneOffset
  , Now()
  , now
  , nowEpochMilliseconds
  , Year(..)
  , Month(..)
  , Day(..)
  , DayOfWeek(..)
  ) where

import Control.Monad.Eff
import Data.Enum
import Data.Function (on, Fn2(), runFn2, Fn3(), runFn3, Fn7(), runFn7)
import Data.Int
import Data.Maybe (Maybe(..))
import Data.Time

newtype Date = DateTime JSDate

instance eqDate :: Eq Date where
  (==) = (==) `on` toEpochMilliseconds
  (/=) = (/=) `on` toEpochMilliseconds

instance ordDate :: Ord Date where
  compare = compare `on` toEpochMilliseconds

instance showDate :: Show Date where
  show d = "(fromEpochMilliseconds " ++ show (toEpochMilliseconds d) ++ ")"

foreign import data JSDate :: *

fromJSDate :: JSDate -> Maybe Date
fromJSDate d =
  if Global.isNaN (runFn2 jsDateMethod "getTime" d)
  then Nothing
  else Just (DateTime d)

toJSDate :: Date -> JSDate
toJSDate (DateTime d) = d

fromEpochMilliseconds :: Milliseconds -> Maybe Date
fromEpochMilliseconds = fromJSDate <<< jsDateFromMilliseconds

toEpochMilliseconds :: Date -> Milliseconds
toEpochMilliseconds (DateTime d) = runFn2 jsDateMethod "getTime" d

fromString :: String -> Maybe Date
fromString = fromJSDate <<< jsDateFromMilliseconds

fromStringStrict :: String -> Maybe Date
fromStringStrict s = runFn3 strictJsDate Just Nothing s >>= fromJSDate

timezoneOffset :: Date -> Minutes
timezoneOffset (DateTime d) = runFn2 jsDateMethod "getTimezoneOffset" d

foreign import data Now :: !

now :: forall e. Eff (now :: Now | e) Date
now = nowImpl DateTime

foreign import nowEpochMilliseconds
  """
  function nowEpochMilliseconds() {
    return Date.now();
  }
  """ :: forall e. Eff (now :: Now | e) Milliseconds

-------------------------------------------------------------------------------

newtype Year = Year Int

instance eqYear :: Eq Year where
  (==) (Year x) (Year y) = x == y
  (/=) (Year x) (Year y) = x /= y

instance ordYear :: Ord Year where
  compare (Year x) (Year y) = compare x y

instance semiringYear :: Semiring Year where
  (+) (Year x) (Year y) = Year (x + y)
  (*) (Year x) (Year y) = Year (x * y)
  zero = Year (fromNumber 0)
  one = Year (fromNumber 1)

instance ringYear :: Ring Year where
  (-) (Year x) (Year y) = Year (x - y)

instance showYear :: Show Year where
  show (Year n) = "(Year " ++ show n ++ ")"

-------------------------------------------------------------------------------

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
  (==) January   January   = true
  (==) February  February  = true
  (==) March     March     = true
  (==) April     April     = true
  (==) May       May       = true
  (==) June      June      = true
  (==) July      July      = true
  (==) August    August    = true
  (==) September September = true
  (==) October   October   = true
  (==) November  November  = true
  (==) December  December  = true
  (==) _         _         = false
  (/=) a         b         = not (a == b)

instance ordMonth :: Ord Month where
  compare = compare `on` fromEnum

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
  firstEnum = January
  lastEnum = December
  succ = defaultSucc monthToEnum monthFromEnum
  pred = defaultPred monthToEnum monthFromEnum
  toEnum = monthToEnum
  fromEnum = monthFromEnum

monthToEnum :: Number -> Maybe Month
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

monthFromEnum :: Month -> Number
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

-------------------------------------------------------------------------------

type Day = Int

data DayOfWeek
  = Sunday
  | Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday

instance eqDayOfWeek :: Eq DayOfWeek where
  (==) Sunday    Sunday    = true
  (==) Monday    Monday    = true
  (==) Tuesday   Tuesday   = true
  (==) Wednesday Wednesday = true
  (==) Thursday  Thursday  = true
  (==) Friday    Friday    = true
  (==) Saturday  Saturday  = true
  (==) _         _         = false
  (/=) a         b         = not (a == b)

instance ordDayOfWeek :: Ord DayOfWeek where
  compare = compare `on` fromEnum

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
  firstEnum = Sunday
  lastEnum = Saturday
  succ = defaultSucc dayOfWeekToEnum dayOfWeekFromEnum
  pred = defaultPred dayOfWeekToEnum dayOfWeekFromEnum
  toEnum = dayOfWeekToEnum
  fromEnum = dayOfWeekFromEnum

dayOfWeekToEnum :: Number -> Maybe DayOfWeek
dayOfWeekToEnum 0 = Just Sunday
dayOfWeekToEnum 1 = Just Monday
dayOfWeekToEnum 2 = Just Tuesday
dayOfWeekToEnum 3 = Just Wednesday
dayOfWeekToEnum 4 = Just Thursday
dayOfWeekToEnum 5 = Just Friday
dayOfWeekToEnum 6 = Just Saturday
dayOfWeekToEnum _ = Nothing

dayOfWeekFromEnum :: DayOfWeek -> Number
dayOfWeekFromEnum Sunday    = 0
dayOfWeekFromEnum Monday    = 1
dayOfWeekFromEnum Tuesday   = 2
dayOfWeekFromEnum Wednesday = 3
dayOfWeekFromEnum Thursday  = 4
dayOfWeekFromEnum Friday    = 5
dayOfWeekFromEnum Saturday  = 6

-------------------------------------------------------------------------------

foreign import nowImpl
  """
  function nowImpl(ctor) {
    return function(){
      return ctor(new Date());
    };
  }
  """ :: forall e. (JSDate -> Date) -> Eff (now :: Now | e) Date

foreign import jsDateFromMilliseconds
  """
  function jsDateFromMilliseconds(x) {
    return new Date(x);
  }
  """ :: forall a. a -> JSDate

foreign import jsDateMethod
  """
  function jsDateMethod(method, date) {
    return date[method]();
  }
  """ :: forall a. Fn2 String JSDate a

foreign import strictJsDate
  """
  function strictJsDate(Just, Nothing, s) {
    var epoch = Date.parse(s);
    if (isNaN(epoch)) return Nothing;
    var date = new Date(epoch);
    var s2 = date.toISOString();
    var idx = s2.indexOf(s);
    if (idx < 0) return Nothing;
    else return Just(date);
  }
  """ :: Fn3 (forall a. a -> Maybe a) (forall a. Maybe a) String (Maybe JSDate)
