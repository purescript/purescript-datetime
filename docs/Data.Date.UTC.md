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


