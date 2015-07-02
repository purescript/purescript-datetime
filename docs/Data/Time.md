## Module Data.Time

#### `HourOfDay`

``` purescript
newtype HourOfDay
  = HourOfDay Int
```

An hour component from a time value. Should fall between 0 and 23
inclusive.

##### Instances
``` purescript
instance eqHourOfDay :: Eq HourOfDay
instance ordHourOfDay :: Ord HourOfDay
```

#### `Hours`

``` purescript
newtype Hours
  = Hours Int
```

A quantity of hours (not necessarily a value between 0 and 23).

##### Instances
``` purescript
instance eqHours :: Eq Hours
instance ordHours :: Ord Hours
instance semiringHours :: Semiring Hours
instance ringHours :: Ring Hours
instance moduloSemiringHours :: ModuloSemiring Hours
instance divisionRingHours :: DivisionRing Hours
instance numHours :: Num Hours
instance showHours :: Show Hours
instance timeValueHours :: TimeValue Hours
```

#### `MinuteOfHour`

``` purescript
newtype MinuteOfHour
  = MinuteOfHour Int
```

A minute component from a time value. Should fall between 0 and 59
inclusive.

##### Instances
``` purescript
instance eqMinuteOfHour :: Eq MinuteOfHour
instance ordMinuteOfHour :: Ord MinuteOfHour
```

#### `Minutes`

``` purescript
newtype Minutes
  = Minutes Int
```

A quantity of minutes (not necessarily a value between 0 and 60).

##### Instances
``` purescript
instance eqMinutes :: Eq Minutes
instance ordMinutes :: Ord Minutes
instance semiringMinutes :: Semiring Minutes
instance ringMinutes :: Ring Minutes
instance moduloSemiringMinutes :: ModuloSemiring Minutes
instance divisionRingMinutes :: DivisionRing Minutes
instance numMinutes :: Num Minutes
instance showMinutes :: Show Minutes
instance timeValueMinutes :: TimeValue Minutes
```

#### `SecondOfMinute`

``` purescript
newtype SecondOfMinute
  = SecondOfMinute Int
```

A second component from a time value. Should fall between 0 and 59
inclusive.

##### Instances
``` purescript
instance eqSecondOfMinute :: Eq SecondOfMinute
instance ordSecondOfMinute :: Ord SecondOfMinute
```

#### `Seconds`

``` purescript
newtype Seconds
  = Seconds Int
```

A quantity of seconds (not necessarily a value between 0 and 60).

##### Instances
``` purescript
instance eqSeconds :: Eq Seconds
instance ordSeconds :: Ord Seconds
instance semiringSeconds :: Semiring Seconds
instance ringSeconds :: Ring Seconds
instance moduloSemiringSeconds :: ModuloSemiring Seconds
instance divisionRingSeconds :: DivisionRing Seconds
instance numSeconds :: Num Seconds
instance showSeconds :: Show Seconds
instance timeValueSeconds :: TimeValue Seconds
```

#### `MillisecondOfSecond`

``` purescript
newtype MillisecondOfSecond
  = MillisecondOfSecond Int
```

A millisecond component from a time value. Should fall between 0 and 999
inclusive.

##### Instances
``` purescript
instance eqMillisecondOfSecond :: Eq MillisecondOfSecond
instance ordMillisecondOfSecond :: Ord MillisecondOfSecond
```

#### `Milliseconds`

``` purescript
newtype Milliseconds
  = Milliseconds Int
```

A quantity of milliseconds (not necessarily a value between 0 and 1000).

##### Instances
``` purescript
instance eqMilliseconds :: Eq Milliseconds
instance ordMilliseconds :: Ord Milliseconds
instance semiringMilliseconds :: Semiring Milliseconds
instance ringMilliseconds :: Ring Milliseconds
instance moduloSemiringMilliseconds :: ModuloSemiring Milliseconds
instance divisionRingMilliseconds :: DivisionRing Milliseconds
instance numMilliseconds :: Num Milliseconds
instance showMilliseconds :: Show Milliseconds
instance timeValueMilliseconds :: TimeValue Milliseconds
```

#### `TimeValue`

``` purescript
class TimeValue a where
  toHours :: a -> Hours
  toMinutes :: a -> Minutes
  toSeconds :: a -> Seconds
  toMilliseconds :: a -> Milliseconds
  fromHours :: Hours -> a
  fromMinutes :: Minutes -> a
  fromSeconds :: Seconds -> a
  fromMilliseconds :: Milliseconds -> a
```

##### Instances
``` purescript
instance timeValueHours :: TimeValue Hours
instance timeValueMinutes :: TimeValue Minutes
instance timeValueSeconds :: TimeValue Seconds
instance timeValueMilliseconds :: TimeValue Milliseconds
```


