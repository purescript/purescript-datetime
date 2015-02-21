# Module Documentation

## Module Data.Date

#### `JSDate`

``` purescript
data JSDate :: *
```


#### `Now`

``` purescript
data Now :: !
```


#### `Date`

``` purescript
data Date
```


#### `eqDate`

``` purescript
instance eqDate :: Eq Date
```


#### `ordDate`

``` purescript
instance ordDate :: Ord Date
```


#### `Year`

``` purescript
type Year = Number
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


#### `Day`

``` purescript
type Day = Number
```


#### `DayOfWeek`

``` purescript
data DayOfWeek
```


#### `Hours`

``` purescript
type Hours = Number
```


#### `Minutes`

``` purescript
type Minutes = Number
```


#### `Seconds`

``` purescript
type Seconds = Number
```


#### `Milliseconds`

``` purescript
type Milliseconds = Number
```


#### `eqMonth`

``` purescript
instance eqMonth :: Eq Month
```


#### `ordMonth`

``` purescript
instance ordMonth :: Ord Month
```


#### `enumMonth`

``` purescript
instance enumMonth :: Enum Month
```


#### `showMonth`

``` purescript
instance showMonth :: Show Month
```


#### `eqDayOfWeek`

``` purescript
instance eqDayOfWeek :: Eq DayOfWeek
```


#### `ordDayOfWeek`

``` purescript
instance ordDayOfWeek :: Ord DayOfWeek
```


#### `enumDayOfWeek`

``` purescript
instance enumDayOfWeek :: Enum DayOfWeek
```


#### `showDayOfWeek`

``` purescript
instance showDayOfWeek :: Show DayOfWeek
```


#### `fromJSDate`

``` purescript
fromJSDate :: JSDate -> Maybe Date
```


#### `toJSDate`

``` purescript
toJSDate :: Date -> JSDate
```


#### `now`

``` purescript
now :: forall e. Eff (now :: Now | e) Date
```


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


#### `yearUTC`

``` purescript
yearUTC :: Date -> Year
```


#### `month`

``` purescript
month :: Date -> Month
```


#### `monthUTC`

``` purescript
monthUTC :: Date -> Month
```


#### `day`

``` purescript
day :: Date -> Day
```


#### `dayUTC`

``` purescript
dayUTC :: Date -> Day
```


#### `dayOfWeek`

``` purescript
dayOfWeek :: Date -> DayOfWeek
```


#### `dayOfWeekUTC`

``` purescript
dayOfWeekUTC :: Date -> DayOfWeek
```


#### `hour`

``` purescript
hour :: Date -> Hours
```


#### `hourUTC`

``` purescript
hourUTC :: Date -> Hours
```


#### `minute`

``` purescript
minute :: Date -> Minutes
```


#### `minuteUTC`

``` purescript
minuteUTC :: Date -> Minutes
```


#### `second`

``` purescript
second :: Date -> Seconds
```


#### `secondUTC`

``` purescript
secondUTC :: Date -> Seconds
```


#### `millisecond`

``` purescript
millisecond :: Date -> Seconds
```


#### `millisecondUTC`

``` purescript
millisecondUTC :: Date -> Seconds
```


#### `timezoneOffset`

``` purescript
timezoneOffset :: Date -> Minutes
```


#### `toEpochMilliseconds`

``` purescript
toEpochMilliseconds :: Date -> Milliseconds
```


#### `fromEpochMilliseconds`

``` purescript
fromEpochMilliseconds :: Milliseconds -> Maybe Date
```


#### `fromString`

``` purescript
fromString :: String -> Maybe Date
```


#### `fromStringStrict`

``` purescript
fromStringStrict :: String -> Maybe Date
```


#### `showDate`

``` purescript
instance showDate :: Show Date
```