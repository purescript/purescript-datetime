module Test.Date where

import Prelude

import Data.Date as Date
import Data.Enum (toEnum)
import Data.Maybe (Maybe(..), fromJust)
import Data.Time.Duration as Duration
import Effect (Effect)
import Effect.Console (log)
import Partial.Unsafe (unsafePartial)
import Test.Assert (assert)
import Test.Helpers (checkBounded, checkBoundedEnum, epochDate)
import Type.Proxy (Proxy(..))

dateTests :: Effect Unit
dateTests = do
  log "--------- Date Tests ---------"
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
  let d4 = unsafePartial fromJust $ Date.canonicalDate <$> toEnum 2018 <*> pure Date.September <*> toEnum 26
  let d5 = unsafePartial fromJust $ Date.canonicalDate <$> toEnum 1988 <*> pure Date.August <*> toEnum 15

  log "Check that diff behaves as expected"
  assert $ Date.diff d2 d1 == Duration.Days 31.0
  assert $ Date.diff d3 d2 == Duration.Days 29.0

  let unsafeYear = unsafePartial fromJust <<< toEnum
  log "Check that isLeapYear behaves as expected"
  assert $ not $ Date.isLeapYear (unsafeYear 2017)
  assert $ Date.isLeapYear (unsafeYear 2016)

  log "Check that epoch is correctly constructed"
  assert $ Just (Date.year epochDate) == toEnum 1
  assert $ Date.month epochDate == bottom
  assert $ Date.day epochDate == bottom

  log "Check that adjust behaves as expected"
  assert $ Date.adjust (Duration.Days 31.0) d1 == Just d2
  assert $ Date.adjust (Duration.Days 999.0) d1 == Just d4
  assert $ Date.adjust (Duration.Days 10000.0) d5 == Just d1
  assert $ Date.adjust (Duration.Days (-31.0)) d2 == Just d1
  assert $ Date.adjust (Duration.Days (- 999.0)) d4 == Just d1
  assert $ Date.adjust (Duration.Days (-10000.0)) d1 == Just d5
