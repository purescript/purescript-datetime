module Data.Date
  ( JSDate()
  , Now()
  , Date()
  , Year()
  , Month(..)
  , Day()
  , DayOfWeek()
  , Hours()
  , Minutes()
  , Seconds()
  , Milliseconds()
  , fromJSDate
  , toJSDate
  , now
  , dateTime
  , date
  , year
  , yearUTC
  , month
  , monthUTC
  , day
  , dayUTC
  , dayOfWeek
  , dayOfWeekUTC
  , hour
  , hourUTC
  , minute
  , minuteUTC
  , second
  , secondUTC
  , millisecond
  , millisecondUTC
  , timezoneOffset
  , toEpochMilliseconds
  , fromEpochMilliseconds
  , fromString
  , fromStringStrict
  ) where

import Control.Monad.Eff
import Data.Enum
import Data.Maybe
import Data.Function
import qualified Data.Maybe.Unsafe as U
  
foreign import jsDateMethod
  "function jsDateMethod(method) { \
  \  return function(date) { \
  \    return date[method](); \
  \  }; \
  \}" :: forall a. String -> JSDate -> a
  
foreign import jsDateConstructor
  "function jsDateConstructor(x) { \
  \  return new Date(x); \
  \}" :: forall a. a -> JSDate

foreign import strictJsDate
  """function strictJsDate(Just, Nothing, s) {
    var epoch = Date.parse(s);
    if (isNaN(epoch)) return Nothing;
    var date = new Date(epoch);
    var s2 = date.toISOString();
    var idx = s2.indexOf(s);
    if (idx < 0) return Nothing;
    else return Just(date);
  }""" :: Fn3 (forall a. a -> Maybe a) (forall a. Maybe a) String (Maybe JSDate)

foreign import jsDateFromRecord
  "function jsDateFromRecord(r) {\
  \  return new Date(r.year, r.month, r.day, r.hours, r.minutes, r.seconds, r.milliseconds); \
  \}" :: { year :: Number
         , month :: Number
         , day :: Number
         , hours :: Number
         , minutes :: Number
         , seconds :: Number
         , milliseconds :: Number } -> JSDate

foreign import data JSDate :: *
foreign import data Now :: !

data Date = DateTime JSDate

instance eqDate :: Eq Date where
  (==) = liftOp (==)  
  (/=) = liftOp (/=) 

instance ordDate :: Ord Date where
  compare = liftOp compare

liftOp :: forall b. (Number -> Number -> b) -> Date -> Date -> b
liftOp op x y = toEpochMilliseconds x `op` toEpochMilliseconds y

type Year = Number

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

type Day = Number

data DayOfWeek
  = Sunday
  | Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday

type Hours = Number
type Minutes = Number
type Seconds = Number
type Milliseconds = Number

instance eqMonth :: Eq Month where
  (==) January January = true
  (==) February February = true
  (==) March March = true
  (==) April April = true
  (==) May May = true
  (==) June June = true
  (==) July July = true
  (==) August August = true
  (==) September September = true
  (==) October October = true
  (==) November November = true
  (==) December December = true
  (==) _ _ = false

  (/=) a b = not (a == b)

instance ordMonth :: Ord Month where
  compare a b = compare (fromEnum a) (fromEnum b)

instance enumMonth :: Enum Month where
  cardinality = Cardinality 12

  firstEnum = January

  lastEnum = December

  succ January    = Just February
  succ February   = Just March
  succ March      = Just April
  succ April      = Just May
  succ May        = Just June
  succ June       = Just July
  succ July       = Just August
  succ August     = Just September
  succ September  = Just October
  succ October    = Just November
  succ November   = Just December
  succ December   = Nothing

  pred January    = Nothing
  pred February   = Just January
  pred March      = Just February
  pred April      = Just March
  pred May        = Just April
  pred June       = Just May
  pred July       = Just June
  pred August     = Just July
  pred September  = Just August
  pred October    = Just September
  pred November   = Just October
  pred December   = Just November
  
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

instance eqDayOfWeek :: Eq DayOfWeek where
  (==) Sunday Sunday = true
  (==) Monday Monday = true
  (==) Tuesday Tuesday = true
  (==) Wednesday Wednesday = true
  (==) Thursday Thursday = true
  (==) Friday Friday = true
  (==) Saturday Saturday = true
  (==) _ _ = false
  
  (/=) a b = not (a == b)

instance ordDayOfWeek :: Ord DayOfWeek where
  compare a b = compare (fromEnum a) (fromEnum b)  
  
instance enumDayOfWeek :: Enum DayOfWeek where
  cardinality = Cardinality 7

  firstEnum = Sunday

  lastEnum = Saturday

  succ Sunday     = Just Monday
  succ Monday     = Just Tuesday
  succ Tuesday    = Just Wednesday
  succ Wednesday  = Just Thursday
  succ Thursday   = Just Friday
  succ Friday     = Just Saturday
  succ Saturday   = Nothing

  pred Sunday     = Nothing
  pred Monday     = Just Sunday
  pred Tuesday    = Just Monday
  pred Wednesday  = Just Tuesday
  pred Thursday   = Just Wednesday
  pred Friday     = Just Thursday
  pred Saturday   = Just Friday
  
instance showDayOfWeek :: Show DayOfWeek where
  show Sunday    = "Sunday"   
  show Monday    = "Monday"  
  show Tuesday   = "Tuesday"  
  show Wednesday = "Wednesday"
  show Thursday  = "Thursday" 
  show Friday    = "Friday"   
  show Saturday  = "Saturday" 

fromJSDate :: JSDate -> Maybe Date
fromJSDate d = if Global.isNaN (jsDateMethod "getTime" d) 
               then Nothing
               else Just $ DateTime d
  
toJSDate :: Date -> JSDate
toJSDate (DateTime d) = d

liftDate :: forall a. (JSDate -> a) -> Date -> a
liftDate f (DateTime d) = f d
  
foreign import nowImpl 
  "function nowImpl(f) { \
  \  return f(new Date()); \
  \}" :: forall e. (JSDate -> Date) -> Eff (now :: Now | e) Date
  
now :: forall e. Eff (now :: Now | e) Date
now = nowImpl DateTime
  
dateTime :: Year -> Month -> Day 
         -> Hours -> Minutes -> Seconds -> Milliseconds
         -> Maybe Date
dateTime y m d h n s ms =
  fromJSDate $ jsDateFromRecord { year: y
                                , month: (fromEnum m)
                                , day: d
                                , hours: h
                                , minutes: n
                                , seconds: s
                                , milliseconds: ms }

date :: Year -> Month -> Day -> Maybe Date
date y m d = dateTime y m d 0 0 0 0

year :: Date -> Year
year = liftDate $ jsDateMethod "getFullYear"

yearUTC :: Date -> Year
yearUTC = liftDate $ jsDateMethod "getUTCFullYear"

month :: Date -> Month
month = U.fromJust <<< toEnum <<< liftDate (jsDateMethod "getMonth")

monthUTC :: Date -> Month
monthUTC = U.fromJust <<< toEnum <<< liftDate (jsDateMethod "getUTCMonth")

day :: Date -> Day
day = liftDate $ jsDateMethod "getDate"

dayUTC :: Date -> Day
dayUTC = liftDate $ jsDateMethod "getUTCDate"

dayOfWeek :: Date -> DayOfWeek
dayOfWeek = U.fromJust <<< toEnum <<< liftDate (jsDateMethod "getDay")

dayOfWeekUTC :: Date -> DayOfWeek
dayOfWeekUTC = U.fromJust <<< toEnum <<< liftDate (jsDateMethod "getUTCDay")

hour :: Date -> Hours
hour = liftDate $ jsDateMethod "getHours"

hourUTC :: Date -> Hours
hourUTC = liftDate $ jsDateMethod "getUTCHours"

minute :: Date -> Minutes
minute = liftDate $ jsDateMethod "getMinutes"

minuteUTC :: Date -> Minutes
minuteUTC = liftDate $ jsDateMethod "getUTCMinutes"

second :: Date -> Seconds
second = liftDate $ jsDateMethod "getSeconds"

secondUTC :: Date -> Seconds
secondUTC = liftDate $ jsDateMethod "getUTCSeconds"

millisecond :: Date -> Seconds
millisecond = liftDate $ jsDateMethod "getMilliseconds"

millisecondUTC :: Date -> Seconds
millisecondUTC = liftDate $ jsDateMethod "getUTCMilliseconds"

timezoneOffset :: Date -> Minutes
timezoneOffset = liftDate $ jsDateMethod "getTimezoneOffset"

toEpochMilliseconds :: Date -> Milliseconds
toEpochMilliseconds = liftDate $ jsDateMethod "getTime"

fromEpochMilliseconds :: Milliseconds -> Maybe Date
fromEpochMilliseconds = fromJSDate <<< jsDateConstructor

fromString :: String -> Maybe Date
fromString = fromJSDate <<< jsDateConstructor

fromStringStrict :: String -> Maybe Date
fromStringStrict s = runFn3 strictJsDate Just Nothing s >>= fromJSDate

instance showDate :: Show Date where
  show = liftDate $ jsDateMethod "toString"
