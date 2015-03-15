module Data.Time where

-- | A quantity of hours (not necessarily a value between 0 and 23).
newtype Hours = Hours Number

instance eqHours :: Eq Hours where
  (==) (Hours x) (Hours y) = x == y
  (/=) (Hours x) (Hours y) = x /= y

instance ordHours :: Ord Hours where
  compare (Hours x) (Hours y) = compare x y

instance semiringHours :: Semiring Hours where
  (+) (Hours x) (Hours y) = Hours (x + y)
  (*) (Hours x) (Hours y) = Hours (x * y)
  zero = Hours 0
  one = Hours 1

instance ringHours :: Ring Hours where
  (-) (Hours x) (Hours y) = Hours (x - y)

instance moduloSemiringHours :: ModuloSemiring Hours where
  (/) (Hours x) (Hours y) = Hours (x / y)
  mod _ _ = Hours 0

instance divisionRingHours :: DivisionRing Hours

instance numHours :: Num Hours

instance showHours :: Show Hours where
  show (Hours n) = "(Hours " ++ show n ++ ")"

-- | A quantity of minutes (not necessarily a value between 0 and 60).
newtype Minutes = Minutes Number

instance eqMinutes :: Eq Minutes where
  (==) (Minutes x) (Minutes y) = x == y
  (/=) (Minutes x) (Minutes y) = x /= y

instance ordMinutes :: Ord Minutes where
  compare (Minutes x) (Minutes y) = compare x y

instance semiringMinutes :: Semiring Minutes where
  (+) (Minutes x) (Minutes y) = Minutes (x + y)
  (*) (Minutes x) (Minutes y) = Minutes (x * y)
  zero = Minutes 0
  one = Minutes 1

instance ringMinutes :: Ring Minutes where
  (-) (Minutes x) (Minutes y) = Minutes (x - y)

instance moduloSemiringMinutes :: ModuloSemiring Minutes where
  (/) (Minutes x) (Minutes y) = Minutes (x / y)
  mod _ _ = Minutes 0

instance divisionRingMinutes :: DivisionRing Minutes

instance numMinutes :: Num Minutes

instance showMinutes :: Show Minutes where
  show (Minutes n) = "(Minutes " ++ show n ++ ")"

-- | A quantity of seconds (not necessarily a value between 0 and 60).
newtype Seconds = Seconds Number

instance eqSeconds :: Eq Seconds where
  (==) (Seconds x) (Seconds y) = x == y
  (/=) (Seconds x) (Seconds y) = x /= y

instance ordSeconds :: Ord Seconds where
  compare (Seconds x) (Seconds y) = compare x y

instance semiringSeconds :: Semiring Seconds where
  (+) (Seconds x) (Seconds y) = Seconds (x + y)
  (*) (Seconds x) (Seconds y) = Seconds (x * y)
  zero = Seconds 0
  one = Seconds 1

instance ringSeconds :: Ring Seconds where
  (-) (Seconds x) (Seconds y) = Seconds (x - y)

instance moduloSemiringSeconds :: ModuloSemiring Seconds where
  (/) (Seconds x) (Seconds y) = Seconds (x / y)
  mod _ _ = Seconds 0

instance divisionRingSeconds :: DivisionRing Seconds

instance numSeconds :: Num Seconds

instance showSeconds :: Show Seconds where
  show (Seconds n) = "(Seconds " ++ show n ++ ")"

-- | A quantity of milliseconds (not necessarily a value between 0 and 1000).
newtype Milliseconds = Milliseconds Number

instance eqMilliseconds :: Eq Milliseconds where
  (==) (Milliseconds x) (Milliseconds y) = x == y
  (/=) (Milliseconds x) (Milliseconds y) = x /= y

instance ordMilliseconds :: Ord Milliseconds where
  compare (Milliseconds x) (Milliseconds y) = compare x y

instance semiringMilliseconds :: Semiring Milliseconds where
  (+) (Milliseconds x) (Milliseconds y) = Milliseconds (x + y)
  (*) (Milliseconds x) (Milliseconds y) = Milliseconds (x * y)
  zero = Milliseconds 0
  one = Milliseconds 1

instance ringMilliseconds :: Ring Milliseconds where
  (-) (Milliseconds x) (Milliseconds y) = Milliseconds (x - y)

instance moduloSemiringMilliseconds :: ModuloSemiring Milliseconds where
  (/) (Milliseconds x) (Milliseconds y) = Milliseconds (x / y)
  mod _ _ = Milliseconds 0

instance divisionRingMilliseconds :: DivisionRing Milliseconds

instance numMilliseconds :: Num Milliseconds

instance showMilliseconds :: Show Milliseconds where
  show (Milliseconds n) = "(Milliseconds " ++ show n ++ ")"
