# Module Documentation

## Module Data.Date

#### `JSDate`

``` purescript
data JSDate :: *
```

A native JavaScript `Date` object.

#### `Date`

``` purescript
newtype Date
```

A combined date/time value. `Date`s cannot be constructed directly to
ensure they are not the `Invalid Date` value, and instead must be created
via `fromJSDate`, `fromEpochMilliseconds`, `fromString`, etc. or the `date`
and `dateTime` functions in the `Data.Date.Locale` and `Data.Date.UTC`
modules.

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


#### `fromJSDate`

``` purescript
fromJSDate :: JSDate -> Maybe Date
```

Attempts to create a `Date` from a `JSDate`. If the `JSDate` is an invalid
date `Nothing` is returned.

#### `toJSDate`

``` purescript
toJSDate :: Date -> JSDate
```

Extracts a `JSDate` from a `Date`.

#### `fromEpochMilliseconds`

``` purescript
fromEpochMilliseconds :: Milliseconds -> Maybe Date
```

Creates a `Date` value from a number of milliseconds elapsed since 1st
January 1970 00:00:00 UTC.

#### `toEpochMilliseconds`

``` purescript
toEpochMilliseconds :: Date -> Milliseconds
```

Gets the number of milliseconds elapsed since 1st January 1970 00:00:00
UTC for a `Date`.

#### `fromString`

``` purescript
fromString :: String -> Maybe Date
```

Attempts to construct a date from a string value using JavaScript’s
[Date.parse() method](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/parse).
`Nothing` is returned if the parse fails or the resulting date is invalid.

#### `fromStringStrict`

``` purescript
fromStringStrict :: String -> Maybe Date
```

Attempts to construct a date from a simplified extended ISO 8601 format
(`YYYY-MM-DDTHH:mm:ss.sssZ`). `Nothing` is returned if the format is not
an exact match or the resulting date is invalid.

#### `Now`

``` purescript
data Now :: !
```

Effect type for when accessing the current date/time.

#### `now`

``` purescript
now :: forall e. Eff (now :: Now | e) Date
```

Gets a `Date` value for the current date/time according to the current
machine’s local time.

#### `nowEpochMilliseconds`

``` purescript
nowEpochMilliseconds :: forall e. Eff (now :: Now | e) Milliseconds
```

Gets the number of milliseconds elapsed milliseconds since 1st January
1970 00:00:00 UTC according to the current machine’s local time

#### `LocaleOffset`

``` purescript
newtype LocaleOffset
  = LocaleOffset Minutes
```

A timezone locale offset, measured in minutes.

#### `timezoneOffset`

``` purescript
timezoneOffset :: Date -> LocaleOffset
```

Get the locale time offset for a `Date`.

#### `Year`

``` purescript
newtype Year
  = Year Int
```

A year date component value.

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

A month date component value.

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


#### `DayOfMonth`

``` purescript
newtype DayOfMonth
  = DayOfMonth Int
```

A day-of-month date component value.

#### `eqDayOfMonth`

``` purescript
instance eqDayOfMonth :: Eq DayOfMonth
```


#### `ordDayOfMonth`

``` purescript
instance ordDayOfMonth :: Ord DayOfMonth
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

A day-of-week date component value.

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

#### `HourOfDay`

``` purescript
newtype HourOfDay
  = HourOfDay Int
```

An hour component from a time value. Should fall between 0 and 23
inclusive.

#### `eqHourOfDay`

``` purescript
instance eqHourOfDay :: Eq HourOfDay
```


#### `ordHourOfDay`

``` purescript
instance ordHourOfDay :: Ord HourOfDay
```


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


#### `MinuteOfHour`

``` purescript
newtype MinuteOfHour
  = MinuteOfHour Int
```

A minute component from a time value. Should fall between 0 and 59
inclusive.

#### `eqMinuteOfHour`

``` purescript
instance eqMinuteOfHour :: Eq MinuteOfHour
```


#### `ordMinuteOfHour`

``` purescript
instance ordMinuteOfHour :: Ord MinuteOfHour
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


#### `SecondOfMinute`

``` purescript
newtype SecondOfMinute
  = SecondOfMinute Int
```

A second component from a time value. Should fall between 0 and 59
inclusive.

#### `eqSecondOfMinute`

``` purescript
instance eqSecondOfMinute :: Eq SecondOfMinute
```


#### `ordSecondOfMinute`

``` purescript
instance ordSecondOfMinute :: Ord SecondOfMinute
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


#### `MillisecondOfSecond`

``` purescript
newtype MillisecondOfSecond
  = MillisecondOfSecond Int
```

A millisecond component from a time value. Should fall between 0 and 999
inclusive.

#### `eqMillisecondOfSecond`

``` purescript
instance eqMillisecondOfSecond :: Eq MillisecondOfSecond
```


#### `ordMillisecondOfSecond`

``` purescript
instance ordMillisecondOfSecond :: Ord MillisecondOfSecond
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
dateTime :: Year -> Month -> DayOfMonth -> HourOfDay -> MinuteOfHour -> SecondOfMinute -> MillisecondOfSecond -> Maybe Date
```

Attempts to create a `Date` from date and time components based on the
current machine’s locale. `Nothing` is returned if the resulting date is
invalid.

#### `date`

``` purescript
date :: Year -> Month -> DayOfMonth -> Maybe Date
```

Attempts to create a `Date` from date components based on the current
machine’s locale. `Nothing` is returned if the resulting date is invalid.

#### `year`

``` purescript
year :: Date -> Year
```

Gets the year component for a date based on the current machine’s locale.

#### `month`

``` purescript
month :: Date -> Month
```

Gets the month component for a date based on the current machine’s locale.

#### `dayOfMonth`

``` purescript
dayOfMonth :: Date -> DayOfMonth
```

Gets the day-of-month value for a date based on the current machine’s
locale.

#### `dayOfWeek`

``` purescript
dayOfWeek :: Date -> DayOfWeek
```

Gets the day-of-week value for a date based on the current machine’s
locale.

#### `hourOfDay`

``` purescript
hourOfDay :: Date -> HourOfDay
```

Gets the hour-of-day value for a date based on the current machine’s
locale.

#### `minuteOfHour`

``` purescript
minuteOfHour :: Date -> MinuteOfHour
```

Gets the minute-of-hour value for a date based on the current machine’s
locale.

#### `secondOfMinute`

``` purescript
secondOfMinute :: Date -> SecondOfMinute
```

Get the second-of-minute value for a date based on the current machine’s
locale.

#### `millisecondOfSecond`

``` purescript
millisecondOfSecond :: Date -> MillisecondOfSecond
```

Get the millisecond-of-second value for a date based on the current
machine’s locale.


## Module Data.Date.UTC

#### `dateTime`

``` purescript
dateTime :: Year -> Month -> DayOfMonth -> HourOfDay -> MinuteOfHour -> SecondOfMinute -> MillisecondOfSecond -> Maybe Date
```

Attempts to create a `Date` from UTC date and time components. `Nothing`
is returned if the resulting date is invalid.

#### `date`

``` purescript
date :: Year -> Month -> DayOfMonth -> Maybe Date
```

Attempts to create a `Date` from UTC date components. `Nothing` is
returned if the resulting date is invalid.

#### `year`

``` purescript
year :: Date -> Year
```

Gets the UTC year component for a date.

#### `month`

``` purescript
month :: Date -> Month
```

Gets the UTC month component for a date.

#### `dayOfMonth`

``` purescript
dayOfMonth :: Date -> DayOfMonth
```

Gets the UTC day-of-month value for a date.

#### `dayOfWeek`

``` purescript
dayOfWeek :: Date -> DayOfWeek
```

Gets the UTC day-of-week value for a date.

#### `hourOfDay`

``` purescript
hourOfDay :: Date -> HourOfDay
```

Gets the UTC hour-of-day value for a date.

#### `minuteOfHour`

``` purescript
minuteOfHour :: Date -> MinuteOfHour
```

Gets the UTC minute-of-hour value for a date.

#### `secondOfMinute`

``` purescript
secondOfMinute :: Date -> SecondOfMinute
```

Get the UTC second-of-minute value for a date.

#### `millisecondOfSecond`

``` purescript
millisecondOfSecond :: Date -> MillisecondOfSecond
```

Get the UTC millisecond-of-second value for a date.



