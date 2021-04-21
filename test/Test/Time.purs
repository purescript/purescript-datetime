module Test.Time
  ( timeTests
  ) where

import Prelude

import Data.Time as Time
import Data.Time.Duration as Duration
import Data.Tuple (Tuple(..), snd)
import Effect (Effect)
import Effect.Console (log)
import Test.Assert (assert)
import Test.Helpers (checkBounded, checkBoundedEnum, time1, time2, time3, time4, time5)
import Type.Proxy (Proxy(..))

timeTests :: Effect Unit
timeTests = do
  log "--------- Time Tests ---------"
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

  log "Check that adjust behaves as expected"
  assert $ Time.adjust (Duration.Milliseconds 1.0) top == Tuple (Duration.Days 1.0) bottom
  assert $ Time.adjust (Duration.Milliseconds (-1.0)) bottom == Tuple (Duration.Days (-1.0)) top
  assert $ Time.adjust (Duration.Minutes 40.0) time1 == Tuple (Duration.Days 0.0) time2
  assert $ Time.adjust (Duration.Days 40.0) time1 == Tuple (Duration.Days 40.0) time1
  assert $ Time.adjust (Duration.fromDuration (Duration.Days 2.0) <> Duration.fromDuration (Duration.Minutes 40.0)) time1 == Tuple (Duration.Days 2.0) time2
  assert $ Time.adjust (Duration.fromDuration (Duration.Days 2.0) <> Duration.fromDuration (Duration.Minutes (-40.0))) time1 == Tuple (Duration.Days 2.0) time3
  assert $ snd (Time.adjust (Duration.fromDuration (Duration.Days 3.872)) time1) == snd (Time.adjust (Duration.fromDuration (Duration.Days 0.872)) time1)
  assert $ Time.adjust (Duration.Hours 2.0) time4 == Tuple (Duration.Days 1.0) time5

  log "Check that diff behaves as expected"
  assert $ Time.diff time2 time1 == Duration.Minutes 40.0
  assert $ Time.diff time1 time2 == Duration.Minutes (-40.0)
  assert $ Time.diff time4 time5 == Duration.Hours 22.0
