module Test.Instant
  ( instantTests
  ) where

import Prelude

import Data.DateTime.Instant as Instant
import Data.Maybe (Maybe(..))
import Data.Time.Duration as Duration
import Effect (Effect)
import Effect.Console (log)
import Test.Assert (assert)
import Test.Helpers (dateTime1, dateTime2, dateTime3, dateTime4, epochDateTime, epochMillis)

instantTests :: Effect Unit
instantTests = do
  log "--------- Instant Tests ---------"
  log "Check that the earliest date is a valid Instant"
  let bottomInstant = Instant.fromDateTime bottom
  assert $ Just bottomInstant == Instant.instant (Instant.unInstant bottomInstant)

  log "Check that the latest date is a valid Instant"
  let topInstant = Instant.fromDateTime top
  assert $ Just topInstant == Instant.instant (Instant.unInstant topInstant)

  log "Check that an Instant can be constructed from epoch"
  assert $ (Instant.unInstant $ Instant.fromDateTime epochDateTime) == Duration.Milliseconds epochMillis

  log "Check that instant/datetime conversion is bijective"
  assert $ Instant.toDateTime (Instant.fromDateTime bottom) == bottom
  assert $ Instant.toDateTime (Instant.fromDateTime top) == top
  assert $ Instant.toDateTime (Instant.fromDateTime dateTime1) == dateTime1
  assert $ Instant.toDateTime (Instant.fromDateTime dateTime2) == dateTime2
  assert $ Instant.toDateTime (Instant.fromDateTime dateTime3) == dateTime3
  assert $ Instant.toDateTime (Instant.fromDateTime dateTime4) == dateTime4
