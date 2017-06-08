module Data.Date.Gen
  ( genDate
  , module Data.Date.Component.Gen
  ) where

import Prelude
import Control.Monad.Gen (class MonadGen)
import Data.Date (Date, canonicalDate)
import Data.Date.Component.Gen (genDay, genMonth, genWeekday, genYear)

-- | Generates a random `Date` between 1st Jan 1900 and 31st Dec 2100,
-- | inclusive.
genDate :: forall m. MonadGen m => m Date
genDate = canonicalDate <$> genYear <*> genMonth <*> genDay
