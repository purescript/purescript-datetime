module Test.DateTime
  ( dateTimeTests
  ) where

import Prelude

import Data.Date as Date
import Data.DateTime as DateTime
import Data.Enum (toEnum)
import Data.Maybe (Maybe(..))
import Data.Newtype (over)
import Data.Time.Duration as Duration
import Effect (Effect)
import Effect.Console (log)
import Math (floor)
import Test.Assert (assert)
import Test.Helpers (dateTime1, dateTime2, dateTime3, dateTime4, dateTime5, epochDateTime)

dateTimeTests :: Effect Unit
dateTimeTests = do
  log "--------- DateTime Tests ---------"
  log "Check that adjust behaves as expected"
  assert $ DateTime.adjust (Duration.fromDuration (Duration.Days 31.0) <> Duration.fromDuration (Duration.Minutes 40.0)) dateTime1 == Just dateTime4
  assert $ (Date.year <<< DateTime.date <$>
           (DateTime.adjust (Duration.Days 735963.0) epochDateTime))
           == toEnum 2016

  log "Check that diff behaves as expected"
  assert $ DateTime.diff dateTime2 dateTime1 == Duration.Minutes 40.0
  assert $ DateTime.diff dateTime1 dateTime2 == Duration.Minutes (-40.0)
  assert $ DateTime.diff dateTime3 dateTime1 == Duration.Days 31.0
  assert $ DateTime.diff dateTime5 dateTime3 == Duration.Days 29.0
  assert $ DateTime.diff dateTime1 dateTime3 == Duration.Days (-31.0)
  assert $ DateTime.diff dateTime4 dateTime1 == Duration.fromDuration (Duration.Days 31.0) <> Duration.fromDuration (Duration.Minutes 40.0)
  assert $ over Duration.Days floor (DateTime.diff dateTime1 epochDateTime)
           == Duration.Days 735963.0
