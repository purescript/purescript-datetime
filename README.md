# Module Documentation

## Module Data.Date

#### `Date`

``` purescript
newtype Date
  = DateTime JSDate
```


#### `eqDate`

``` purescript
instance eqDate :: Eq Date
```


#### `ordDate`

``` purescript
instance ordDate :: Ord Date
```


#### `showDate`

``` purescript
instance showDate :: Show Date
```


#### `JSDate`

``` purescript
data JSDate :: *
```


#### `fromJSDate`

``` purescript
fromJSDate :: JSDate -> Maybe Date
```


#### `toJSDate`

``` purescript
toJSDate :: Date -> JSDate
```


#### `fromEpochMilliseconds`

``` purescript
fromEpochMilliseconds :: Milliseconds -> Maybe Date
```


#### `toEpochMilliseconds`

``` purescript
toEpochMilliseconds :: Date -> Milliseconds
```


#### `fromString`

``` purescript
fromString :: String -> Maybe Date
```


#### `fromStringStrict`

``` purescript
fromStringStrict :: String -> Maybe Date
```


#### `timezoneOffset`

``` purescript
timezoneOffset :: Date -> Minutes
```


#### `Now`

``` purescript
data Now :: !
```


#### `now`

``` purescript
now :: forall e. Eff (now :: Now | e) Date
```


#### `nowEpochMilliseconds`

``` purescript
nowEpochMilliseconds :: forall e. Eff (now :: Now | e) Milliseconds
```


#### `Year`

``` purescript
newtype Year
  = Year Int
```

#### `eqYear`

``` purescript
instance eqYear :: Eq Year
```


#### `ordYear`

``` purescript
instance ordYear :: Ord Year
```


#### `semiringYear`

``` purescript
instance semiringYear :: Semiring Year
```


#### `ringYear`

``` purescript
instance ringYear :: Ring Year
```


#### `showYear`

``` purescript
instance showYear :: Show Year
```


#### `Month`

``` purescript
data Month
  = January 
  | February 
  | March 
  | April 
  | May 
  | June 
  | July 
  | August 
  | September 
  | October 
  | November 
  | December 
```

#### `eqMonth`

``` purescript
instance eqMonth :: Eq Month
```


#### `ordMonth`

``` purescript
instance ordMonth :: Ord Month
```


#### `showMonth`

``` purescript
instance showMonth :: Show Month
```


#### `enumMonth`

``` purescript
instance enumMonth :: Enum Month
```


#### `Day`

``` purescript
type Day = Int
```

#### `DayOfWeek`

``` purescript
data DayOfWeek
  = Sunday 
  | Monday 
  | Tuesday 
  | Wednesday 
  | Thursday 
  | Friday 
  | Saturday 
```


#### `eqDayOfWeek`

``` purescript
instance eqDayOfWeek :: Eq DayOfWeek
```


#### `ordDayOfWeek`

``` purescript
instance ordDayOfWeek :: Ord DayOfWeek
```


#### `showDayOfWeek`

``` purescript
instance showDayOfWeek :: Show DayOfWeek
```


#### `enumDayOfWeek`

``` purescript
instance enumDayOfWeek :: Enum DayOfWeek
```



## Module Data.Time

#### `Hours`

``` purescript
newtype Hours
  = Hours Number
```

A quantity of hours (not necessarily a value between 0 and 23).

#### `eqHours`

``` purescript
instance eqHours :: Eq Hours
```


#### `ordHours`

``` purescript
instance ordHours :: Ord Hours
```


#### `semiringHours`

``` purescript
instance semiringHours :: Semiring Hours
```


#### `ringHours`

``` purescript
instance ringHours :: Ring Hours
```


#### `moduloSemiringHours`

``` purescript
instance moduloSemiringHours :: ModuloSemiring Hours
```


#### `divisionRingHours`

``` purescript
instance divisionRingHours :: DivisionRing Hours
```


#### `numHours`

``` purescript
instance numHours :: Num Hours
```


#### `showHours`

``` purescript
instance showHours :: Show Hours
```


#### `Minutes`

``` purescript
newtype Minutes
  = Minutes Number
```

A quantity of minutes (not necessarily a value between 0 and 60).

#### `eqMinutes`

``` purescript
instance eqMinutes :: Eq Minutes
```


#### `ordMinutes`

``` purescript
instance ordMinutes :: Ord Minutes
```


#### `semiringMinutes`

``` purescript
instance semiringMinutes :: Semiring Minutes
```


#### `ringMinutes`

``` purescript
instance ringMinutes :: Ring Minutes
```


#### `moduloSemiringMinutes`

``` purescript
instance moduloSemiringMinutes :: ModuloSemiring Minutes
```


#### `divisionRingMinutes`

``` purescript
instance divisionRingMinutes :: DivisionRing Minutes
```


#### `numMinutes`

``` purescript
instance numMinutes :: Num Minutes
```


#### `showMinutes`

``` purescript
instance showMinutes :: Show Minutes
```


#### `Seconds`

``` purescript
newtype Seconds
  = Seconds Number
```

A quantity of seconds (not necessarily a value between 0 and 60).

#### `eqSeconds`

``` purescript
instance eqSeconds :: Eq Seconds
```


#### `ordSeconds`

``` purescript
instance ordSeconds :: Ord Seconds
```


#### `semiringSeconds`

``` purescript
instance semiringSeconds :: Semiring Seconds
```


#### `ringSeconds`

``` purescript
instance ringSeconds :: Ring Seconds
```


#### `moduloSemiringSeconds`

``` purescript
instance moduloSemiringSeconds :: ModuloSemiring Seconds
```


#### `divisionRingSeconds`

``` purescript
instance divisionRingSeconds :: DivisionRing Seconds
```


#### `numSeconds`

``` purescript
instance numSeconds :: Num Seconds
```


#### `showSeconds`

``` purescript
instance showSeconds :: Show Seconds
```


#### `Milliseconds`

``` purescript
newtype Milliseconds
  = Milliseconds Number
```

A quantity of milliseconds (not necessarily a value between 0 and 1000).

#### `eqMilliseconds`

``` purescript
instance eqMilliseconds :: Eq Milliseconds
```


#### `ordMilliseconds`

``` purescript
instance ordMilliseconds :: Ord Milliseconds
```


#### `semiringMilliseconds`

``` purescript
instance semiringMilliseconds :: Semiring Milliseconds
```


#### `ringMilliseconds`

``` purescript
instance ringMilliseconds :: Ring Milliseconds
```


#### `moduloSemiringMilliseconds`

``` purescript
instance moduloSemiringMilliseconds :: ModuloSemiring Milliseconds
```


#### `divisionRingMilliseconds`

``` purescript
instance divisionRingMilliseconds :: DivisionRing Milliseconds
```


#### `numMilliseconds`

``` purescript
instance numMilliseconds :: Num Milliseconds
```


#### `showMilliseconds`

``` purescript
instance showMilliseconds :: Show Milliseconds
```



## Module Data.Date.Locale

#### `dateTime`

``` purescript
dateTime :: Year -> Month -> Day -> Hours -> Minutes -> Seconds -> Milliseconds -> Maybe Date
```


#### `date`

``` purescript
date :: Year -> Month -> Day -> Maybe Date
```


#### `year`

``` purescript
year :: Date -> Year
```


#### `month`

``` purescript
month :: Date -> Month
```


#### `day`

``` purescript
day :: Date -> Day
```


#### `dayOfWeek`

``` purescript
dayOfWeek :: Date -> DayOfWeek
```


#### `hour`

``` purescript
hour :: Date -> Hours
```


#### `minute`

``` purescript
minute :: Date -> Minutes
```


#### `second`

``` purescript
second :: Date -> Seconds
```


#### `millisecond`

``` purescript
millisecond :: Date -> Milliseconds
```



## Module Data.Date.UTC

#### `dateTime`

``` purescript
dateTime :: Year -> Month -> Day -> Hours -> Minutes -> Seconds -> Milliseconds -> Maybe Date
```


#### `date`

``` purescript
date :: Year -> Month -> Day -> Maybe Date
```


#### `year`

``` purescript
year :: Date -> Year
```


#### `month`

``` purescript
month :: Date -> Month
```


#### `day`

``` purescript
day :: Date -> Day
```


#### `dayOfWeek`

``` purescript
dayOfWeek :: Date -> DayOfWeek
```


#### `hour`

``` purescript
hour :: Date -> Hours
```


#### `minute`

``` purescript
minute :: Date -> Minutes
```


#### `second`

``` purescript
second :: Date -> Seconds
```


#### `millisecond`

``` purescript
millisecond :: Date -> Milliseconds
```




