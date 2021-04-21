module Test.Duration
  ( durationTests
  ) where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Data.Either (Either(..), isRight)
import Data.Interval as Interval
import Data.Interval.Duration.Iso as IsoDuration
import Test.Assert (assert)

durationTests :: Effect Unit
durationTests = do
  log "--------- Durations Tests ---------"
  log "check Duration monoid"
  assert $ Interval.year 1.0 == mempty <> Interval.year 2.0 <> Interval.year 1.0 <> Interval.year (-2.0)
  assert $ Interval.second 0.5 == Interval.millisecond 500.0
  assert $ IsoDuration.mkIsoDuration (Interval.week 1.2 <> Interval.week 1.2)
    == IsoDuration.mkIsoDuration (Interval.week 2.4)
  assert $ isRight $ IsoDuration.mkIsoDuration (Interval.day 1.2 <> mempty)
  assert $ isRight $ IsoDuration.mkIsoDuration (Interval.day 1.2 <> Interval.second 0.0)
  assert $ isRight $ IsoDuration.mkIsoDuration (Interval.year 2.0 <> Interval.day 1.0)
  assert $ IsoDuration.mkIsoDuration (Interval.year 2.5 <> Interval.day 1.0)
    == Left (pure (IsoDuration.InvalidFractionalUse Interval.Year))
  log $ show $ IsoDuration.mkIsoDuration (Interval.year 2.5 <> Interval.week 1.0)
    == Left (pure IsoDuration.InvalidWeekComponentUsage <> pure (IsoDuration.InvalidFractionalUse Interval.Year))
  assert $ IsoDuration.mkIsoDuration (Interval.year 2.0 <> Interval.day (-1.0))
    == Left (pure (IsoDuration.ContainsNegativeValue Interval.Day))
  assert $ IsoDuration.mkIsoDuration (mempty)
    == Left (pure IsoDuration.IsEmpty)
