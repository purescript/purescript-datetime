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

##### Instances
``` purescript
instance eqDate :: Eq Date
instance ordDate :: Ord Date
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

##### Instances
``` purescript
instance eqYear :: Eq Year
instance ordYear :: Ord Year
instance semiringYear :: Semiring Year
instance ringYear :: Ring Year
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

##### Instances
``` purescript
instance eqMonth :: Eq Month
instance ordMonth :: Ord Month
instance boundedMonth :: Bounded Month
instance boundedOrdMonth :: BoundedOrd Month
instance showMonth :: Show Month
instance enumMonth :: Enum Month
```

#### `DayOfMonth`

``` purescript
newtype DayOfMonth
  = DayOfMonth Int
```

A day-of-month date component value.

##### Instances
``` purescript
instance eqDayOfMonth :: Eq DayOfMonth
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

##### Instances
``` purescript
instance eqDayOfWeek :: Eq DayOfWeek
instance ordDayOfWeek :: Ord DayOfWeek
instance boundedDayOfWeek :: Bounded DayOfWeek
instance boundedOrdDayOfWeek :: BoundedOrd DayOfWeek
instance showDayOfWeek :: Show DayOfWeek
instance enumDayOfWeek :: Enum DayOfWeek
```


