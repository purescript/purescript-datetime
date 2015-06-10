module Data.Time where

import Prelude
  ( (*)
  , (+)
  , (++)
  , (-)
  , (/)
  , (/=)
  , (==)
  , DivisionRing
  , Eq
  , ModuloSemiring
  , Num
  , Ord
  , Ring
  , Semiring
  , Show
  , compare
  , show )

-- | An hour component from a time value. Should fall between 0 and 23
-- | inclusive.
newtype HourOfDay = HourOfDay Int

instance eqHourOfDay :: Eq HourOfDay where
  eq (HourOfDay x) (HourOfDay y) = x == y

instance ordHourOfDay :: Ord HourOfDay where
  compare (HourOfDay x) (HourOfDay y) = compare x y

-- | A quantity of hours (not necessarily a value between 0 and 23).
newtype Hours = Hours Int

instance eqHours :: Eq Hours where
  eq (Hours x) (Hours y) = x == y

instance ordHours :: Ord Hours where
  compare (Hours x) (Hours y) = compare x y

instance semiringHours :: Semiring Hours where
  add (Hours x) (Hours y) = Hours (x + y)
  mul (Hours x) (Hours y) = Hours (x * y)
  zero = Hours 0
  one = Hours 1

instance ringHours :: Ring Hours where
  sub (Hours x) (Hours y) = Hours (x - y)

instance moduloSemiringHours :: ModuloSemiring Hours where
  div (Hours x) (Hours y) = Hours (x / y)
  mod _ _ = Hours 0

instance divisionRingHours :: DivisionRing Hours

instance numHours :: Num Hours

instance showHours :: Show Hours where
  show (Hours n) = "(Hours " ++ show n ++ ")"

-- | A minute component from a time value. Should fall between 0 and 59
-- | inclusive.
newtype MinuteOfHour = MinuteOfHour Int

instance eqMinuteOfHour :: Eq MinuteOfHour where
  eq (MinuteOfHour x) (MinuteOfHour y) = x == y

instance ordMinuteOfHour :: Ord MinuteOfHour where
  compare (MinuteOfHour x) (MinuteOfHour y) = compare x y

-- | A quantity of minutes (not necessarily a value between 0 and 60).
newtype Minutes = Minutes Int

instance eqMinutes :: Eq Minutes where
  eq (Minutes x) (Minutes y) = x == y

instance ordMinutes :: Ord Minutes where
  compare (Minutes x) (Minutes y) = compare x y

instance semiringMinutes :: Semiring Minutes where
  add (Minutes x) (Minutes y) = Minutes (x + y)
  mul (Minutes x) (Minutes y) = Minutes (x * y)
  zero = Minutes 0
  one = Minutes 1

instance ringMinutes :: Ring Minutes where
  sub (Minutes x) (Minutes y) = Minutes (x - y)

instance moduloSemiringMinutes :: ModuloSemiring Minutes where
  div (Minutes x) (Minutes y) = Minutes (x / y)
  mod _ _ = Minutes 0

instance divisionRingMinutes :: DivisionRing Minutes

instance numMinutes :: Num Minutes

instance showMinutes :: Show Minutes where
  show (Minutes n) = "(Minutes " ++ show n ++ ")"

-- | A second component from a time value. Should fall between 0 and 59
-- | inclusive.
newtype SecondOfMinute = SecondOfMinute Int

instance eqSecondOfMinute :: Eq SecondOfMinute where
  eq (SecondOfMinute x) (SecondOfMinute y) = x == y

instance ordSecondOfMinute :: Ord SecondOfMinute where
  compare (SecondOfMinute x) (SecondOfMinute y) = compare x y

-- | A quantity of seconds (not necessarily a value between 0 and 60).
newtype Seconds = Seconds Int

instance eqSeconds :: Eq Seconds where
  eq (Seconds x) (Seconds y) = x == y

instance ordSeconds :: Ord Seconds where
  compare (Seconds x) (Seconds y) = compare x y

instance semiringSeconds :: Semiring Seconds where
  add (Seconds x) (Seconds y) = Seconds (x + y)
  mul (Seconds x) (Seconds y) = Seconds (x * y)
  zero = Seconds 0
  one = Seconds 1

instance ringSeconds :: Ring Seconds where
  sub (Seconds x) (Seconds y) = Seconds (x - y)

instance moduloSemiringSeconds :: ModuloSemiring Seconds where
  div (Seconds x) (Seconds y) = Seconds (x / y)
  mod _ _ = Seconds 0

instance divisionRingSeconds :: DivisionRing Seconds

instance numSeconds :: Num Seconds

instance showSeconds :: Show Seconds where
  show (Seconds n) = "(Seconds " ++ show n ++ ")"

-- | A millisecond component from a time value. Should fall between 0 and 999
-- | inclusive.
newtype MillisecondOfSecond = MillisecondOfSecond Int

instance eqMillisecondOfSecond :: Eq MillisecondOfSecond where
  eq (MillisecondOfSecond x) (MillisecondOfSecond y) = x == y

instance ordMillisecondOfSecond :: Ord MillisecondOfSecond where
  compare (MillisecondOfSecond x) (MillisecondOfSecond y) = compare x y

-- | A quantity of milliseconds (not necessarily a value between 0 and 1000).
newtype Milliseconds = Milliseconds Int

instance eqMilliseconds :: Eq Milliseconds where
  eq (Milliseconds x) (Milliseconds y) = x == y

instance ordMilliseconds :: Ord Milliseconds where
  compare (Milliseconds x) (Milliseconds y) = compare x y

instance semiringMilliseconds :: Semiring Milliseconds where
  add (Milliseconds x) (Milliseconds y) = Milliseconds (x + y)
  mul (Milliseconds x) (Milliseconds y) = Milliseconds (x * y)
  zero = Milliseconds 0
  one = Milliseconds 1

instance ringMilliseconds :: Ring Milliseconds where
  sub (Milliseconds x) (Milliseconds y) = Milliseconds (x - y)

instance moduloSemiringMilliseconds :: ModuloSemiring Milliseconds where
  div (Milliseconds x) (Milliseconds y) = Milliseconds (x / y)
  mod _ _ = Milliseconds 0

instance divisionRingMilliseconds :: DivisionRing Milliseconds

instance numMilliseconds :: Num Milliseconds

instance showMilliseconds :: Show Milliseconds where
  show (Milliseconds n) = "(Milliseconds " ++ show n ++ ")"

class TimeValue a where
  toHours :: a -> Hours
  toMinutes :: a -> Minutes
  toSeconds :: a -> Seconds
  toMilliseconds :: a -> Milliseconds
  fromHours :: Hours -> a
  fromMinutes :: Minutes -> a
  fromSeconds :: Seconds -> a
  fromMilliseconds :: Milliseconds -> a

instance timeValueHours :: TimeValue Hours where
  toHours n = n
  toMinutes (Hours n) = Minutes (n * 60)
  toSeconds (Hours n) = Seconds (n * 3600)
  toMilliseconds (Hours n) = Milliseconds (n * 3600000)
  fromHours n = n
  fromMinutes (Minutes n) = Hours (n / 60)
  fromSeconds (Seconds n) = Hours (n / 3600)
  fromMilliseconds (Milliseconds n) = Hours (n / 3600000)

instance timeValueMinutes :: TimeValue Minutes where
  toHours (Minutes n) = Hours (n / 60)
  toMinutes n = n
  toSeconds (Minutes n) = Seconds (n * 60)
  toMilliseconds (Minutes n) = Milliseconds (n * 60000)
  fromHours (Hours n) = Minutes (n * 60)
  fromMinutes n = n
  fromSeconds (Seconds n) = Minutes (n / 60)
  fromMilliseconds (Milliseconds n) = Minutes (n / 60000)

instance timeValueSeconds :: TimeValue Seconds where
  toHours (Seconds n) = Hours (n / 3600)
  toMinutes (Seconds n) = Minutes (n / 60)
  toSeconds n = n
  toMilliseconds (Seconds n) = Milliseconds (n * 1000)
  fromHours (Hours n) = Seconds (n * 3600)
  fromMinutes (Minutes n) = Seconds (n * 60)
  fromSeconds n = n
  fromMilliseconds (Milliseconds n) = Seconds (n / 1000)

instance timeValueMilliseconds :: TimeValue Milliseconds where
  toHours (Milliseconds n) = Hours (n / 3600000)
  toMinutes (Milliseconds n) = Minutes (n / 60000)
  toSeconds (Milliseconds n) = Seconds (n / 1000)
  toMilliseconds n = n
  fromHours (Hours n) = Milliseconds (n * 3600000)
  fromMinutes (Minutes n) = Milliseconds (n * 60000)
  fromSeconds (Seconds n) = Milliseconds (n * 1000)
  fromMilliseconds n = n
