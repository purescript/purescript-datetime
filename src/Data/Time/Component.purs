module Data.Time.Component
  ( Hour
  , MinHour
  , MaxHour
  , hour
  , Minute
  , MinMinute
  , MaxMinute
  , minute
  , Second
  , MinSecond
  , MaxSecond
  , second
  , Millisecond
  , MinMillisecond
  , MaxMillisecond
  , millisecond
  ) where

import Prelude

import Data.Enum (class Enum, class BoundedEnum, toEnum, fromEnum, Cardinality(..))
import Data.Maybe (Maybe(..))
import Data.Reflectable (class Reflectable, reflectType)
import Prim.Int as PI
import Prim.Ordering as PO
import Type.Proxy (Proxy(..))

-- | An hour component for a time value.
-- |
-- | The constructor is private as values for the type are restricted to the
-- | range 0 to 23, inclusive. The `toEnum` function can be used to safely
-- | acquire an `Hour` value from an integer. Correspondingly, an `Hour` can be
-- | lowered to a plain integer with the `fromEnum` function.
newtype Hour = Hour Int

derive newtype instance eqHour :: Eq Hour
derive newtype instance ordHour :: Ord Hour

type MinHour :: Int
type MinHour = 0

type MaxHour :: Int
type MaxHour = 23

-- intentionally not exported
hourBottom :: Int
hourBottom = reflectType (Proxy :: Proxy 0)

-- intentionally not exported
hourTop :: Int
hourTop = reflectType (Proxy :: Proxy 23)

-- | Constructs an Hour using a type-level integer.
-- | ```
-- | hour (Proxy :: Proxy 4)
-- | ```
hour
  :: forall i lower upper
   . Reflectable i Int
  => PI.Add MinHour (-1) lower
  => PI.Compare i lower PO.GT
  => PI.Add MaxHour 1 upper
  => PI.Compare i upper PO.LT
  => Proxy i
  -> Hour
hour p = Hour $ reflectType p

instance boundedHour :: Bounded Hour where
  bottom = Hour hourBottom
  top = Hour hourTop

instance enumHour :: Enum Hour where
  succ = toEnum <<< (_ + 1) <<< fromEnum
  pred = toEnum <<< (_ - 1) <<< fromEnum

instance boundedEnumHour :: BoundedEnum Hour where
  cardinality = Cardinality $ hourTop - hourBottom + 1
  toEnum n
    | n >= hourTop && n <= hourTop = Just (Hour n)
    | otherwise = Nothing
  fromEnum (Hour n) = n

instance showHour :: Show Hour where
  show (Hour h) = "(Hour " <> show h <> ")"

-- | An minute component for a time value.
-- |
-- | The constructor is private as values for the type are restricted to the
-- | range 0 to 59, inclusive. The `toEnum` function can be used to safely
-- | acquire an `Minute` value from an integer. Correspondingly, a `Minute` can
-- | be lowered to a plain integer with the `fromEnum` function.
newtype Minute = Minute Int

derive newtype instance eqMinute :: Eq Minute
derive newtype instance ordMinute :: Ord Minute

type MinMinute :: Int
type MinMinute = 0

type MaxMinute :: Int
type MaxMinute = 59

-- intentionally not exported
minuteBottom :: Int
minuteBottom = reflectType (Proxy :: Proxy MinMinute)

-- intentionally not exported
minuteTop :: Int
minuteTop = reflectType (Proxy :: Proxy MaxMinute)

-- | Constructs a Minute using a type-level integer.
-- | ```
-- | minute (Proxy :: Proxy 4)
-- | ```
minute
  :: forall i lower upper
   . Reflectable i Int
  => PI.Add MinMinute (-1) lower
  => PI.Compare i lower PO.GT
  => PI.Add MaxMinute 1 upper
  => PI.Compare i upper PO.LT
  => Proxy i
  -> Minute
minute p = Minute $ reflectType p

instance boundedMinute :: Bounded Minute where
  bottom = Minute minuteBottom
  top = Minute minuteTop

instance enumMinute :: Enum Minute where
  succ = toEnum <<< (_ + 1) <<< fromEnum
  pred = toEnum <<< (_ - 1) <<< fromEnum

instance boundedEnumMinute :: BoundedEnum Minute where
  cardinality = Cardinality $ minuteTop - minuteBottom + 1
  toEnum n
    | n >= minuteBottom && n <= minuteTop = Just (Minute n)
    | otherwise = Nothing
  fromEnum (Minute n) = n

instance showMinute :: Show Minute where
  show (Minute m) = "(Minute " <> show m <> ")"

-- | An second component for a time value.
-- |
-- | The constructor is private as values for the type are restricted to the
-- | range 0 to 59, inclusive. The `toEnum` function can be used to safely
-- | acquire an `Second` value from an integer. Correspondingly, a `Second` can
-- | be lowered to a plain integer with the `fromEnum` function.
newtype Second = Second Int

derive newtype instance eqSecond :: Eq Second
derive newtype instance ordSecond :: Ord Second

type MinSecond :: Int
type MinSecond = 0

type MaxSecond :: Int
type MaxSecond = 59

-- intentionally not exported
secondBottom :: Int
secondBottom = reflectType (Proxy :: Proxy MinSecond)

-- intentionally not exported
secondTop :: Int
secondTop = reflectType (Proxy :: Proxy MaxSecond)

-- | Constructs a Second using a type-level integer.
-- | ```
-- | second (Proxy :: Proxy 4)
-- | ```
second
  :: forall i lower upper
   . Reflectable i Int
  => PI.Add MinSecond (-1) lower
  => PI.Compare i lower PO.GT
  => PI.Add MaxSecond 1 upper
  => PI.Compare i upper PO.LT
  => Proxy i
  -> Second
second p = Second $ reflectType p

instance boundedSecond :: Bounded Second where
  bottom = Second secondBottom
  top = Second secondTop

instance enumSecond :: Enum Second where
  succ = toEnum <<< (_ + 1) <<< fromEnum
  pred = toEnum <<< (_ - 1) <<< fromEnum

instance boundedEnumSecond :: BoundedEnum Second where
  cardinality = Cardinality $ secondTop - secondBottom + 1
  toEnum n
    | n >= secondBottom && n <= secondTop = Just (Second n)
    | otherwise = Nothing
  fromEnum (Second n) = n

instance showSecond :: Show Second where
  show (Second m) = "(Second " <> show m <> ")"

-- | An millisecond component for a time value.
-- |
-- | The constructor is private as values for the type are restricted to the
-- | range 0 to 999, inclusive. The `toEnum` function can be used to safely
-- | acquire an `Millisecond` value from an integer. Correspondingly, a
-- | `Millisecond` can be lowered to a plain integer with the `fromEnum`
-- | function.
newtype Millisecond = Millisecond Int

derive newtype instance eqMillisecond :: Eq Millisecond
derive newtype instance ordMillisecond :: Ord Millisecond

type MinMillisecond :: Int
type MinMillisecond = 0

type MaxMillisecond :: Int
type MaxMillisecond = 999

-- intentionally not exported
millisecondBottom :: Int
millisecondBottom = reflectType (Proxy :: Proxy MinSecond)

-- intentionally not exported
millisecondTop :: Int
millisecondTop = reflectType (Proxy :: Proxy MaxSecond)

-- | Constructs a Millisecond using a type-level integer.
-- | ```
-- | millisecond (Proxy :: Proxy 4)
-- | ```
millisecond
  :: forall i lower upper
   . Reflectable i Int
  => PI.Add MinMillisecond (-1) lower
  => PI.Compare i lower PO.GT
  => PI.Add MaxMillisecond 1 upper
  => PI.Compare i upper PO.LT
  => Proxy i
  -> Millisecond
millisecond p = Millisecond $ reflectType p

instance boundedMillisecond :: Bounded Millisecond where
  bottom = Millisecond millisecondBottom
  top = Millisecond millisecondTop

instance enumMillisecond :: Enum Millisecond where
  succ = toEnum <<< (_ + 1) <<< fromEnum
  pred = toEnum <<< (_ - 1) <<< fromEnum

instance boundedEnumMillisecond :: BoundedEnum Millisecond where
  cardinality = Cardinality $ millisecondTop - millisecondBottom + 1
  toEnum n
    | n >= millisecondBottom && n <= millisecondTop = Just (Millisecond n)
    | otherwise = Nothing
  fromEnum (Millisecond n) = n

instance showMillisecond :: Show Millisecond where
  show (Millisecond m) = "(Millisecond " <> show m <> ")"
