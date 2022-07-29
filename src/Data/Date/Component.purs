module Data.Date.Component
  ( Year
  , MinYear
  , MaxYear
  , year
  , Month(..)
  , MinMonth
  , MaxMonth
  , month
  , Day
  , MinDay
  , MaxDay
  , day
  , Weekday(..)
  ) where

import Prelude

import Data.Enum (class Enum, class BoundedEnum, toEnum, fromEnum, Cardinality(..))
import Data.Maybe (Maybe(..), fromJust)
import Data.Reflectable (class Reflectable, reflectType)
import Prim.Int as PI
import Prim.Ordering as PO
import Type.Proxy (Proxy(..))

-- | A year component for a date.
-- |
-- | The constructor is private as the `Year` type is bounded to the range
-- | -271820 to 275759, inclusive. The `toEnum` function can be used to safely
-- | acquire a year value from an integer.
newtype Year = Year Int

derive newtype instance eqYear :: Eq Year
derive newtype instance ordYear :: Ord Year

type MinYear :: Int
type MinYear = -271820

type MaxYear :: Int
type MaxYear = 275759

-- | Constructs a Year using a type-level integer.
-- | ```
-- | year (Proxy :: Proxy 4)
-- | ```
year
  :: forall i lower upper
   . Reflectable i Int
  => PI.Add MinYear (-1) lower
  => PI.Compare i lower PO.GT
  => PI.Add MinYear 1 upper
  => PI.Compare i upper PO.LT
  => Proxy i
  -> Year
year p = Year $ reflectType p

-- intentionally not exported
yearBottom :: Int
yearBottom = reflectType (Proxy :: Proxy MinYear)

-- intentionally not exported
yearTop :: Int
yearTop = reflectType (Proxy :: Proxy MaxYear)

-- Note: these seemingly arbitrary bounds come from relying on JS for date
-- manipulations, as it only supports date ±100,000,000 days of the Unix epoch.
-- Using these year values means `Date bottom bottom bottom` is a valid date,
-- likewise for `top`.
instance boundedYear :: Bounded Year where
  bottom = Year yearBottom
  top = Year yearTop

instance enumYear :: Enum Year where
  succ = toEnum <<< (_ + 1) <<< fromEnum
  pred = toEnum <<< (_ - 1) <<< fromEnum

instance boundedEnumYear :: BoundedEnum Year where
  cardinality = Cardinality $ yearTop - yearBottom
  toEnum n
    | n >= yearBottom && n <= yearTop = Just (Year n)
    | otherwise = Nothing
  fromEnum (Year n) = n

instance showYear :: Show Year where
  show (Year y) = "(Year " <> show y <> ")"

-- | A month component for a date in the Gregorian calendar.
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

derive instance eqMonth :: Eq Month
derive instance ordMonth :: Ord Month

type MinMonth :: Int
type MinMonth = 1

type MaxMonth :: Int
type MaxMonth = 12

-- | Constructs a Month using a type-level integer.
-- | ```
-- | month (Proxy :: Proxy 11)
-- | ```
month
  :: forall i lower upper
   . Reflectable i Int
  => PI.Add MinMonth (-1) lower
  => PI.Compare i 0 PO.GT
  => PI.Add MaxMonth 1 upper
  => PI.Compare i 13 PO.LT
  => Proxy i
  -> Month
month p = case reflectType p of
  1 -> January
  2 -> February
  3 -> March
  4 -> April
  5 -> May
  6 -> June
  7 -> July
  8 -> August
  9 -> September
  10 -> October
  11 -> November
  _ -> December

instance boundedMonth :: Bounded Month where
  bottom = January
  top = December

instance enumMonth :: Enum Month where
  succ = toEnum <<< (_ + 1) <<< fromEnum
  pred = toEnum <<< (_ - 1) <<< fromEnum

instance boundedEnumMonth :: BoundedEnum Month where
  cardinality = Cardinality 12
  toEnum = case _ of
    1 -> Just January
    2 -> Just February
    3 -> Just March
    4 -> Just April
    5 -> Just May
    6 -> Just June
    7 -> Just July
    8 -> Just August
    9 -> Just September
    10 -> Just October
    11 -> Just November
    12 -> Just December
    _ -> Nothing
  fromEnum = case _ of
    January -> 1
    February -> 2
    March -> 3
    April -> 4
    May -> 5
    June -> 6
    July -> 7
    August -> 8
    September -> 9
    October -> 10
    November -> 11
    December -> 12

instance showMonth :: Show Month where
  show January = "January"
  show February = "February"
  show March = "March"
  show April = "April"
  show May = "May"
  show June = "June"
  show July = "July"
  show August = "August"
  show September = "September"
  show October = "October"
  show November = "November"
  show December = "December"

-- | A day component for a date.
-- |
-- | The constructor is private as the `Day` type is bounded to the range
-- | 1 to 31, inclusive. The `toEnum` function can be used to safely
-- | acquire a day value from an integer.
newtype Day = Day Int

derive newtype instance eqDay :: Eq Day
derive newtype instance ordDay :: Ord Day

type MinDay :: Int
type MinDay = 1

type MaxDay :: Int
type MaxDay = 31

-- intentionally not exported
dayBottom :: Int
dayBottom = reflectType (Proxy :: Proxy MinDay)

-- intentionally not exported
dayTop :: Int
dayTop = reflectType (Proxy :: Proxy MaxDay)

-- | Constructs a Day using a type-level integer.
-- | ```
-- | day (Proxy :: Proxy 11)
-- | ```
day
  :: forall i lower upper
   . Reflectable i Int
  => PI.Add MinDay (-1) lower
  => PI.Compare i lower PO.GT
  => PI.Add MaxDay 1 upper
  => PI.Compare i upper PO.LT
  => Proxy i
  -> Day
day p = Day $ reflectType p

instance boundedDay :: Bounded Day where
  bottom = Day dayBottom
  top = Day dayTop

instance enumDay :: Enum Day where
  succ = toEnum <<< (_ + 1) <<< fromEnum
  pred = toEnum <<< (_ - 1) <<< fromEnum

instance boundedEnumDay :: BoundedEnum Day where
  cardinality = Cardinality $ dayTop - dayBottom + 1
  toEnum n
    | n >= dayBottom && n <= dayTop = Just (Day n)
    | otherwise = Nothing
  fromEnum (Day n) = n

instance showDay :: Show Day where
  show (Day d) = "(Day " <> show d <> ")"

-- | A type representing the days of the week in the Gregorian calendar.
data Weekday
  = Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday
  | Sunday

derive instance eqWeekday :: Eq Weekday
derive instance ordWeekday :: Ord Weekday

instance boundedWeekday :: Bounded Weekday where
  bottom = Monday
  top = Sunday

instance enumWeekday :: Enum Weekday where
  succ = toEnum <<< (_ + 1) <<< fromEnum
  pred = toEnum <<< (_ - 1) <<< fromEnum

instance boundedEnumWeekday :: BoundedEnum Weekday where
  cardinality = Cardinality 7
  toEnum = case _ of
    1 -> Just Monday
    2 -> Just Tuesday
    3 -> Just Wednesday
    4 -> Just Thursday
    5 -> Just Friday
    6 -> Just Saturday
    7 -> Just Sunday
    _ -> Nothing
  fromEnum = case _ of
    Monday -> 1
    Tuesday -> 2
    Wednesday -> 3
    Thursday -> 4
    Friday -> 5
    Saturday -> 6
    Sunday -> 7

instance showWeekday :: Show Weekday where
  show Monday = "Monday"
  show Tuesday = "Tuesday"
  show Wednesday = "Wednesday"
  show Thursday = "Thursday"
  show Friday = "Friday"
  show Saturday = "Saturday"
  show Sunday = "Sunday"
