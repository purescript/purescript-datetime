module Data.DateTime.Internal
  ( adjust
  , diff
  , normalize
  , weekday
  , DateTimeRec
  ) where

import Data.Maybe (Maybe(..))
import Data.Time.Duration (Milliseconds)

type DateTimeRec =
  { year :: Int
  , month :: Int
  , day :: Int
  , hour :: Int
  , minute :: Int
  , second :: Int
  , millisecond :: Int
  }

adjust :: Milliseconds -> DateTimeRec -> Maybe DateTimeRec
adjust = adjustImpl Just Nothing

foreign import adjustImpl
  :: (forall a. a -> Maybe a)
  -> (forall a. Maybe a)
  -> Milliseconds
  -> DateTimeRec
  -> Maybe DateTimeRec

foreign import normalize
  :: DateTimeRec
  -> DateTimeRec

foreign import weekday
  :: DateTimeRec
  -> Int

foreign import diff
  :: DateTimeRec
  -> DateTimeRec
  -> Milliseconds
