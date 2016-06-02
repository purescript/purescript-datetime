module Data.Time.Duration where

import Prelude

import Data.Generic (class Generic)

-- | A duration measured in milliseconds.
newtype Milliseconds = Milliseconds Number

unMilliseconds :: Milliseconds -> Number
unMilliseconds (Milliseconds ms) = ms

derive instance eqMilliseconds :: Eq Milliseconds
derive instance ordMilliseconds :: Ord Milliseconds
derive instance genericMilliseconds :: Generic Milliseconds

instance semiringMilliseconds :: Semiring Milliseconds where
  add (Milliseconds x) (Milliseconds y) = Milliseconds (x + y)
  mul (Milliseconds x) (Milliseconds y) = Milliseconds (x * y)
  zero = Milliseconds 0.0
  one = Milliseconds 1.0

instance ringMilliseconds :: Ring Milliseconds where
  sub (Milliseconds x) (Milliseconds y) = Milliseconds (x - y)

instance showMilliseconds :: Show Milliseconds where
  show (Milliseconds n) = "(Milliseconds " <> show n <> ")"

-- | A duration measured in seconds.
newtype Seconds = Seconds Number

unSeconds :: Seconds -> Number
unSeconds (Seconds s) = s

derive instance eqSeconds :: Eq Seconds
derive instance ordSeconds :: Ord Seconds
derive instance genericSeconds :: Generic Seconds

instance semiringSeconds :: Semiring Seconds where
  add (Seconds x) (Seconds y) = Seconds (x + y)
  mul (Seconds x) (Seconds y) = Seconds (x * y)
  zero = Seconds 0.0
  one = Seconds 1.0

instance ringSeconds :: Ring Seconds where
  sub (Seconds x) (Seconds y) = Seconds (x - y)

instance showSeconds :: Show Seconds where
  show (Seconds n) = "(Seconds " <> show n <> ")"

-- | A duration measured in minutes.
newtype Minutes = Minutes Number

unMinutes :: Minutes -> Number
unMinutes (Minutes m) = m

derive instance eqMinutes :: Eq Minutes
derive instance ordMinutes :: Ord Minutes
derive instance genericMinutes :: Generic Minutes

instance semiringMinutes :: Semiring Minutes where
  add (Minutes x) (Minutes y) = Minutes (x + y)
  mul (Minutes x) (Minutes y) = Minutes (x * y)
  zero = Minutes 0.0
  one = Minutes 1.0

instance ringMinutes :: Ring Minutes where
  sub (Minutes x) (Minutes y) = Minutes (x - y)

instance showMinutes :: Show Minutes where
  show (Minutes n) = "(Minutes " <> show n <> ")"

-- | A duration measured in hours.
newtype Hours = Hours Number

unHours :: Hours -> Number
unHours (Hours m) = m

derive instance eqHours :: Eq Hours
derive instance ordHours :: Ord Hours
derive instance genericHours :: Generic Hours

instance semiringHours :: Semiring Hours where
  add (Hours x) (Hours y) = Hours (x + y)
  mul (Hours x) (Hours y) = Hours (x * y)
  zero = Hours 0.0
  one = Hours 1.0

instance ringHours :: Ring Hours where
  sub (Hours x) (Hours y) = Hours (x - y)

instance showHours :: Show Hours where
  show (Hours n) = "(Hours " <> show n <> ")"

-- | A duration measured in days, where a day is assumed to be exactly 24 hours.
newtype Days = Days Number

unDays :: Days -> Number
unDays (Days m) = m

derive instance eqDays :: Eq Days
derive instance ordDays :: Ord Days
derive instance genericDays :: Generic Days

instance semiringDays :: Semiring Days where
  add (Days x) (Days y) = Days (x + y)
  mul (Days x) (Days y) = Days (x * y)
  zero = Days 0.0
  one = Days 1.0

instance ringDays :: Ring Days where
  sub (Days x) (Days y) = Days (x - y)

instance showDays :: Show Days where
  show (Days n) = "(Days " <> show n <> ")"

-- | A class for enabling conversions between duration types.
class Duration a where
  fromDuration :: a -> Milliseconds
  toDuration :: Milliseconds -> a

-- | Converts directly between durations of differing types.
convertDuration :: forall a b. (Duration a, Duration b) => a -> b
convertDuration = toDuration <<< fromDuration

instance durationMilliseconds :: Duration Milliseconds where
  fromDuration = id
  toDuration = id

instance durationSeconds :: Duration Seconds where
  fromDuration = Milliseconds <<< (_ * 1000.0) <<< unSeconds
  toDuration (Milliseconds ms) = Seconds (ms / 1000.0)

instance durationMinutes :: Duration Minutes where
  fromDuration = Milliseconds <<< (_ * 60000.0) <<< unMinutes
  toDuration (Milliseconds ms) = Minutes (ms / 60000.0)

instance durationHours :: Duration Hours where
  fromDuration = Milliseconds <<< (_ * 3600000.0) <<< unHours
  toDuration (Milliseconds ms) = Hours (ms / 3600000.0)

instance durationDays :: Duration Days where
  fromDuration = Milliseconds <<< (_ * 86400000.0) <<< unDays
  toDuration (Milliseconds ms) = Days (ms / 86400000.0)
