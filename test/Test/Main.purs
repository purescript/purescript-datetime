module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Test.Date (dateTests)
import Test.DateTime (dateTimeTests)
import Test.Duration (durationTests)
import Test.Instant (instantTests)
import Test.Time (timeTests)

main :: Effect Unit
main = do
  durationTests
  timeTests
  dateTests
  dateTimeTests
  instantTests
  log "All tests done"
