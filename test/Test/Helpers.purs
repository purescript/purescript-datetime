module Test.Helpers
  ( checkBounded
  , checkBoundedEnum
  , date1
  , date2
  , date3
  , date4
  , date5
  , dateTime1
  , dateTime2
  , dateTime3
  , dateTime4
  , dateTime5
  , epochDate
  , epochDateTime
  , epochMillis
  , time1
  , time2
  , time3
  , time4
  , time5
  ) where

import Prelude

import Data.Array as Array
import Data.Date as Date
import Data.DateTime as DateTime
import Data.Enum (class BoundedEnum, Cardinality, toEnum, enumFromTo, cardinality, succ, fromEnum, pred)
import Data.Maybe (Maybe(..), fromJust)
import Data.Newtype (unwrap)
import Data.Time as Time
import Effect (Effect)
import Partial.Unsafe (unsafePartial)
import Test.Assert (assert)
import Type.Proxy (Proxy)

checkBounded :: forall e. Bounded e => Proxy e -> Effect Unit
checkBounded _ = do
  assert $ Just (bottom :: Time.Hour) == toEnum (fromEnum (bottom :: Time.Hour))
  assert $ pred (bottom :: Time.Hour) == Nothing
  assert $ Just (top :: Time.Hour) == toEnum (fromEnum (top :: Time.Hour))
  assert $ succ (top :: Time.Hour) == Nothing

checkBoundedEnum :: forall e. BoundedEnum e => Proxy e -> Effect Unit
checkBoundedEnum p = do
  checkBounded p
  let card = unwrap (cardinality :: Cardinality e)
  assert $ Array.length (enumFromTo bottom (top :: e)) == card


date1 :: Date.Date
date1 = unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.January <*> toEnum 1

date2 :: Date.Date
date2 = unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.February <*> toEnum 1

date3 :: Date.Date
date3 = unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.March <*> toEnum 1

date4 :: Date.Date
date4 = unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2018 <*> pure Date.September <*> toEnum 26

date5 :: Date.Date
date5 = unsafePartial fromJust $ Date.canonicalDate <$> toEnum 1988 <*> pure Date.August <*> toEnum 15


dateTime1 :: DateTime.DateTime
dateTime1 = DateTime.DateTime date1 time1

dateTime2 :: DateTime.DateTime
dateTime2 = DateTime.DateTime date1 time2

dateTime3 :: DateTime.DateTime
dateTime3 = DateTime.DateTime date2 time1

dateTime4 :: DateTime.DateTime
dateTime4 = DateTime.DateTime date2 time2

dateTime5 :: DateTime.DateTime
dateTime5 = DateTime.DateTime date3 time1

epochDate :: Date.Date
epochDate = unsafePartial fromJust $ Date.canonicalDate
                  <$> toEnum 1
                  <*> pure bottom
                  <*> pure bottom

epochDateTime :: DateTime.DateTime
epochDateTime = DateTime.DateTime epochDate bottom

epochMillis :: Number
epochMillis = -62135596800000.0

time1 :: Time.Time
time1 = unsafePartial $ fromJust $ Time.Time <$> toEnum 17 <*> toEnum 42 <*> toEnum 16 <*> toEnum 362

time2 :: Time.Time
time2 = unsafePartial $ fromJust $ Time.Time <$> toEnum 18 <*> toEnum 22 <*> toEnum 16 <*> toEnum 362

time3 :: Time.Time
time3 = unsafePartial $ fromJust $ Time.Time <$> toEnum 17 <*> toEnum 2 <*> toEnum 16 <*> toEnum 362

time4 :: Time.Time
time4 = unsafePartial $ fromJust $ Time.Time <$> toEnum 23 <*> toEnum 0 <*> toEnum 0 <*> toEnum 0

time5 :: Time.Time
time5 = unsafePartial $ fromJust $ Time.Time <$> toEnum 1 <*> toEnum 0 <*> toEnum 0 <*> toEnum 0
