## Module Data.Date.Locale

#### `Locale`

``` purescript
data Locale :: !
```

The effect of reading the current system locale/timezone.

#### `dateTime`

``` purescript
dateTime :: forall e. Year -> Month -> DayOfMonth -> HourOfDay -> MinuteOfHour -> SecondOfMinute -> MillisecondOfSecond -> Eff (locale :: Locale | e) (Maybe Date)
```

Attempts to create a `Date` from date and time components based on the
current machine’s locale. `Nothing` is returned if the resulting date is
invalid.

#### `date`

``` purescript
date :: forall e. Year -> Month -> DayOfMonth -> Eff (locale :: Locale | e) (Maybe Date)
```

Attempts to create a `Date` from date components based on the current
machine’s locale. `Nothing` is returned if the resulting date is invalid.

#### `year`

``` purescript
year :: forall e. Date -> Eff (locale :: Locale | e) Year
```

Gets the year component for a date based on the current machine’s locale.

#### `month`

``` purescript
month :: forall e. Date -> Eff (locale :: Locale | e) Month
```

Gets the month component for a date based on the current machine’s locale.

#### `dayOfMonth`

``` purescript
dayOfMonth :: forall e. Date -> Eff (locale :: Locale | e) DayOfMonth
```

Gets the day-of-month value for a date based on the current machine’s
locale.

#### `dayOfWeek`

``` purescript
dayOfWeek :: forall e. Date -> Eff (locale :: Locale | e) DayOfWeek
```

Gets the day-of-week value for a date based on the current machine’s
locale.

#### `hourOfDay`

``` purescript
hourOfDay :: forall e. Date -> Eff (locale :: Locale | e) HourOfDay
```

Gets the hour-of-day value for a date based on the current machine’s
locale.

#### `minuteOfHour`

``` purescript
minuteOfHour :: forall e. Date -> Eff (locale :: Locale | e) MinuteOfHour
```

Gets the minute-of-hour value for a date based on the current machine’s
locale.

#### `secondOfMinute`

``` purescript
secondOfMinute :: forall e. Date -> Eff (locale :: Locale | e) SecondOfMinute
```

Get the second-of-minute value for a date based on the current machine’s
locale.

#### `millisecondOfSecond`

``` purescript
millisecondOfSecond :: forall e. Date -> Eff (locale :: Locale | e) MillisecondOfSecond
```

Get the millisecond-of-second value for a date based on the current
machine’s locale.

#### `toLocaleString`

``` purescript
toLocaleString :: forall e. Date -> Eff (locale :: Locale | e) String
```

Format a date as a human-readable string (including the date and the
time), based on the current machine's locale. Example output:
"Fri May 22 2015 19:45:07 GMT+0100 (BST)", although bear in mind that this
can vary significantly across platforms.

#### `toLocaleTimeString`

``` purescript
toLocaleTimeString :: forall e. Date -> Eff (locale :: Locale | e) String
```

Format a time as a human-readable string, based on the current machine's
locale. Example output: "19:45:07", although bear in mind that this
can vary significantly across platforms.

#### `toLocaleDateString`

``` purescript
toLocaleDateString :: forall e. Date -> Eff (locale :: Locale | e) String
```

Format a date as a human-readable string, based on the current machine's
locale. Example output: "Friday, May 22, 2015", although bear in mind that
this can vary significantly across platforms.


