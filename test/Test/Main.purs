module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

import Data.Enum (class BoundedEnum, Cardinality, toEnum, enumFromTo, cardinality, succ, fromEnum, pred)
import Data.Date as Date
import Data.Time as Time
import Data.Time.Duration as Duration
import Data.Array as Array
import Data.DateTime as DateTime
import Data.DateTime.Instant as Instant
import Data.Maybe (Maybe(..), fromJust)
import Data.Tuple (Tuple(..), snd)
import Data.Newtype (unwrap)

import Type.Proxy (Proxy(..))
import Test.Assert (ASSERT, assert)
import Partial.Unsafe (unsafePartial)

type Tests = Eff (console :: CONSOLE, assert :: ASSERT) Unit

main :: Tests
main = do

  -- time --------------------------------------------------------------------

  log "Check that Hour is a good BoundedEnum"
  checkBoundedEnum (Proxy :: Proxy Time.Hour)

  log "Check that Minute is a good BoundedEnum"
  checkBoundedEnum (Proxy :: Proxy Time.Minute)

  log "Check that Second is a good BoundedEnum"
  checkBoundedEnum (Proxy :: Proxy Time.Second)

  log "Check that Millisecond is a good BoundedEnum"
  checkBoundedEnum (Proxy :: Proxy Time.Millisecond)

  log "Check that Time is a good Bounded"
  checkBounded (Proxy :: Proxy Time.Time)

  let t1 = unsafePartial $ fromJust $ Time.Time <$> toEnum 17 <*> toEnum 42 <*> toEnum 16 <*> toEnum 362
  let t2 = unsafePartial $ fromJust $ Time.Time <$> toEnum 18 <*> toEnum 22 <*> toEnum 16 <*> toEnum 362
  let t3 = unsafePartial $ fromJust $ Time.Time <$> toEnum 17 <*> toEnum 2 <*> toEnum 16 <*> toEnum 362
  let t4 = unsafePartial $ fromJust $ Time.Time <$> toEnum 23 <*> toEnum 0 <*> toEnum 0 <*> toEnum 0
  let t5 = unsafePartial $ fromJust $ Time.Time <$> toEnum 1 <*> toEnum 0 <*> toEnum 0 <*> toEnum 0

  log "Check that adjust behaves as expected"
  assert $ Time.adjust (Duration.Milliseconds 1.0) top == Tuple (Duration.Days 1.0) bottom
  assert $ Time.adjust (Duration.Milliseconds (-1.0)) bottom == Tuple (Duration.Days (-1.0)) top
  assert $ Time.adjust (Duration.Minutes 40.0) t1 == Tuple zero t2
  assert $ Time.adjust (Duration.Days 40.0) t1 == Tuple (Duration.Days 40.0) t1
  assert $ Time.adjust (Duration.fromDuration (Duration.Days 2.0) + Duration.fromDuration (Duration.Minutes 40.0)) t1 == Tuple (Duration.Days 2.0) t2
  assert $ Time.adjust (Duration.fromDuration (Duration.Days 2.0) - Duration.fromDuration (Duration.Minutes 40.0)) t1 == Tuple (Duration.Days 2.0) t3
  assert $ snd (Time.adjust (Duration.fromDuration (Duration.Days 3.872)) t1) == snd (Time.adjust (Duration.fromDuration (Duration.Days 0.872)) t1)
  assert $ Time.adjust (Duration.Hours 2.0) t4 == Tuple (Duration.Days 1.0) t5

  log "Check that diff behaves as expected"
  assert $ Time.diff t2 t1 == Duration.Minutes 40.0
  assert $ Time.diff t1 t2 == Duration.Minutes (-40.0)
  assert $ Time.diff t4 t5 == Duration.Hours 22.0

  -- date --------------------------------------------------------------------

  log "Check that Year is a good BoundedEnum"
  checkBoundedEnum (Proxy :: Proxy Date.Year)

  log "Check that Month is a good BoundedEnum"
  checkBoundedEnum (Proxy :: Proxy Date.Month)

  log "Check that Day is a good BoundedEnum"
  checkBoundedEnum (Proxy :: Proxy Date.Day)

  log "Check that Date is a good Bounded"
  checkBounded (Proxy :: Proxy Date.Date)

  log "Check that the earliest date is a valid date"
  assert $ Just bottom == Date.exactDate bottom bottom bottom

  log "Check that the latest date is a valid date"
  assert $ Just top == Date.exactDate top top top

  log "Check that weekday behaves as expected"
  assert $ Date.weekday (unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.June <*> toEnum 6) == Date.Monday
  assert $ Date.weekday (unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.June <*> toEnum 7) == Date.Tuesday
  assert $ Date.weekday (unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.June <*> toEnum 8) == Date.Wednesday
  assert $ Date.weekday (unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.June <*> toEnum 9) == Date.Thursday
  assert $ Date.weekday (unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.June <*> toEnum 10) == Date.Friday
  assert $ Date.weekday (unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.June <*> toEnum 11) == Date.Saturday
  assert $ Date.weekday (unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.June <*> toEnum 12) == Date.Sunday

  let d1 = unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.January <*> toEnum 1
  let d2 = unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.February <*> toEnum 1
  let d3 = unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2016 <*> pure Date.March <*> toEnum 1

  log "Check that diff behaves as expected"
  assert $ Date.diff d2 d1 == Duration.Days 31.0
  assert $ Date.diff d3 d2 == Duration.Days 29.0

  let unsafeYear = unsafePartial fromJust <<< toEnum
  log "Check that isLeapYear behaves as expected"
  assert $ not $ Date.isLeapYear (unsafeYear 2017)
  assert $ Date.isLeapYear (unsafeYear 2016)

  -- datetime ----------------------------------------------------------------

  let dt1 = DateTime.DateTime d1 t1
  let dt2 = DateTime.DateTime d1 t2
  let dt3 = DateTime.DateTime d2 t1
  let dt4 = DateTime.DateTime d2 t2
  let dt5 = DateTime.DateTime d3 t1

  log "Check that adjust behaves as expected"
  assert $ DateTime.adjust (Duration.fromDuration (Duration.Days 31.0) + Duration.fromDuration (Duration.Minutes 40.0)) dt1 == Just dt4

  log "Check that diff behaves as expected"
  assert $ DateTime.diff dt2 dt1 == Duration.Minutes 40.0
  assert $ DateTime.diff dt1 dt2 == Duration.Minutes (-40.0)
  assert $ DateTime.diff dt3 dt1 == Duration.Days 31.0
  assert $ DateTime.diff dt5 dt3 == Duration.Days 29.0
  assert $ DateTime.diff dt1 dt3 == Duration.Days (-31.0)
  assert $ DateTime.diff dt4 dt1 == Duration.fromDuration (Duration.Days 31.0) + Duration.fromDuration (Duration.Minutes 40.0)

  -- instant -----------------------------------------------------------------

  log "Check that the earliest date is a valid Instant"
  let bottomInstant = Instant.fromDateTime bottom
  assert $ Just bottomInstant == Instant.instant (Instant.unInstant bottomInstant)

  log "Check that the latest date is a valid Instant"
  let topInstant = Instant.fromDateTime top
  assert $ Just topInstant == Instant.instant (Instant.unInstant topInstant)

  log "Check that instant/datetime conversion is bijective"
  assert $ Instant.toDateTime (Instant.fromDateTime bottom) == bottom
  assert $ Instant.toDateTime (Instant.fromDateTime top) == top
  assert $ Instant.toDateTime (Instant.fromDateTime dt1) == dt1
  assert $ Instant.toDateTime (Instant.fromDateTime dt2) == dt2
  assert $ Instant.toDateTime (Instant.fromDateTime dt3) == dt3
  assert $ Instant.toDateTime (Instant.fromDateTime dt4) == dt4

  log "All tests done"

checkBounded :: forall e. Bounded e => Proxy e -> Tests
checkBounded _ = do
  assert $ Just (bottom :: Time.Hour) == toEnum (fromEnum (bottom :: Time.Hour))
  assert $ pred (bottom :: Time.Hour) == Nothing
  assert $ Just (top :: Time.Hour) == toEnum (fromEnum (top :: Time.Hour))
  assert $ succ (top :: Time.Hour) == Nothing

checkBoundedEnum :: forall e. BoundedEnum e => Proxy e -> Tests
checkBoundedEnum p = do
  checkBounded p
  let card = unwrap (cardinality :: Cardinality e)
  assert $ Array.length (enumFromTo bottom (top :: e)) == card
