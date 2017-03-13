module Data.Time.Duration where

import Prelude

import Data.Generic (class Generic)
import Data.Newtype (class Newtype, over)

-- | A duration measured in milliseconds.
newtype Milliseconds = Milliseconds Number

derive instance newtypeMilliseconds :: Newtype Milliseconds _
derive instance genericMilliseconds :: Generic Milliseconds
derive newtype instance eqMilliseconds :: Eq Milliseconds
derive newtype instance ordMilliseconds :: Ord Milliseconds
derive newtype instance semiringMilliseconds :: Semiring Milliseconds
derive newtype instance ringMilliseconds :: Ring Milliseconds

instance showMilliseconds :: Show Milliseconds where
  show (Milliseconds n) = "(Milliseconds " <> show n <> ")"

-- | A duration measured in seconds.
newtype Seconds = Seconds Number

derive instance newtypeSeconds :: Newtype Seconds _
derive instance genericSeconds :: Generic Seconds
derive newtype instance eqSeconds :: Eq Seconds
derive newtype instance ordSeconds :: Ord Seconds
derive newtype instance semiringSeconds :: Semiring Seconds
derive newtype instance ringSeconds :: Ring Seconds

instance showSeconds :: Show Seconds where
  show (Seconds n) = "(Seconds " <> show n <> ")"

-- | A duration measured in minutes.
newtype Minutes = Minutes Number

derive instance newtypeMinutes :: Newtype Minutes _
derive instance genericMinutes :: Generic Minutes
derive newtype instance eqMinutes :: Eq Minutes
derive newtype instance ordMinutes :: Ord Minutes
derive newtype instance semiringMinutes :: Semiring Minutes
derive newtype instance ringMinutes :: Ring Minutes

instance showMinutes :: Show Minutes where
  show (Minutes n) = "(Minutes " <> show n <> ")"

-- | A duration measured in hours.
newtype Hours = Hours Number

derive instance newtypeHours :: Newtype Hours _
derive instance genericHours :: Generic Hours
derive newtype instance eqHours :: Eq Hours
derive newtype instance ordHours :: Ord Hours
derive newtype instance semiringHours :: Semiring Hours
derive newtype instance ringHours :: Ring Hours

instance showHours :: Show Hours where
  show (Hours n) = "(Hours " <> show n <> ")"

-- | A duration measured in days, where a day is assumed to be exactly 24 hours.
newtype Days = Days Number

derive instance newtypeDays :: Newtype Days _
derive instance genericDays :: Generic Days
derive newtype instance eqDays :: Eq Days
derive newtype instance ordDays :: Ord Days
derive newtype instance semiringDays :: Semiring Days
derive newtype instance ringDays :: Ring Days

instance showDays :: Show Days where
  show (Days n) = "(Days " <> show n <> ")"

-- | A class for enabling conversions between duration types.
class Duration a where
  fromDuration :: a -> Milliseconds
  toDuration :: Milliseconds -> a

-- | Converts directly between durations of differing types.
convertDuration :: forall a b. Duration a => Duration b => a -> b
convertDuration = toDuration <<< fromDuration

instance durationMilliseconds :: Duration Milliseconds where
  fromDuration = id
  toDuration = id

instance durationSeconds :: Duration Seconds where
  fromDuration = over Seconds (_ * 1000.0)
  toDuration = over Milliseconds (_ / 1000.0)

instance durationMinutes :: Duration Minutes where
  fromDuration = over Minutes (_ * 60000.0)
  toDuration = over Milliseconds (_ / 60000.0)

instance durationHours :: Duration Hours where
  fromDuration = over Hours (_ * 3600000.0)
  toDuration = over Milliseconds (_ / 3600000.0)

instance durationDays :: Duration Days where
  fromDuration = over Days (_ * 86400000.0)
  toDuration = over Milliseconds (_ / 86400000.0)
