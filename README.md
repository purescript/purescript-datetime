# Module Documentation

## Module Data.Date

### Types

    data Date

    type Day = Prim.Number

    data DayOfWeek

    type Hours = Prim.Number

    data JSDate :: *

    type Milliseconds = Prim.Number

    type Minutes = Prim.Number

    data Month where
      January :: Month
      February :: Month
      March :: Month
      April :: Month
      May :: Month
      June :: Month
      July :: Month
      August :: Month
      September :: Month
      October :: Month
      November :: Month
      December :: Month

    data Now :: !

    type Seconds = Prim.Number

    type Year = Prim.Number


### Type Class Instances

    instance enumDayOfWeek :: Data.Enum.Enum DayOfWeek

    instance enumMonth :: Data.Enum.Enum Month

    instance eqDate :: Prelude.Eq Date

    instance ordDate :: Prelude.Ord Date

    instance showDate :: Prelude.Show Date

    instance showDayOfWeek :: Prelude.Show DayOfWeek

    instance showMonth :: Prelude.Show Month


### Values

    date :: Year -> Month -> Day -> Maybe Date

    dateTime :: Year -> Month -> Day -> Hours -> Minutes -> Seconds -> Milliseconds -> Maybe Date

    day :: Date -> Day

    dayOfWeek :: Date -> DayOfWeek

    dayOfWeekUTC :: Date -> DayOfWeek

    dayUTC :: Date -> Day

    fromEpochMilliseconds :: Milliseconds -> Maybe Date

    fromJSDate :: JSDate -> Maybe Date

    fromString :: Prim.String -> Maybe Date

    hour :: Date -> Hours

    hourUTC :: Date -> Hours

    millisecond :: Date -> Seconds

    millisecondUTC :: Date -> Seconds

    minute :: Date -> Minutes

    minuteUTC :: Date -> Minutes

    month :: Date -> Month

    monthUTC :: Date -> Month

    now :: forall e. Eff (now :: Now | e) Date

    second :: Date -> Seconds

    secondUTC :: Date -> Seconds

    timezoneOffset :: Date -> Minutes

    toEpochMilliseconds :: Date -> Milliseconds

    toJSDate :: Date -> JSDate

    year :: Date -> Year

    yearUTC :: Date -> Year