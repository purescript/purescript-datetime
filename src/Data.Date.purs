module Data.Date where

  import Prelude
  import Eff
  import Enum
  import Maybe
  
  unsafeFromJust :: forall a. Maybe a -> a
  unsafeFromJust (Just a) = a
    
  foreign import jsDateMethod
    "function jsDateMethod(method) { \
    \  return function(date) { \
    \    return date[method](); \
    \  }; \
    \}" :: forall a. String -> JSDate -> a
    
  foreign import jsDateConstructor
    "function jsDateConstructor(x) { \
    \  return new Date(x); \
    \}" :: forall a. a -> JSDate

  foreign import jsDateFromRecord
    "function jsDateFromRecord(r) {\
    \  return new Date(r.year, r.month, r.day, r.hours, r.minutes, r.seconds, r.milliseconds); \
    \}" :: { year :: Number
           , month :: Number
           , day :: Number
           , hours :: Number
           , minutes :: Number
           , seconds :: Number
           , milliseconds :: Number } -> JSDate

  foreign import data JSDate :: *
  foreign import data Now :: !
  
  data Date = DateTime JSDate
  
  type Year = Number
  
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
  
  type Day = Number
  
  data DayOfWeek
    = Sunday
    | Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday
    | Saturday
  
  type Hours = Number
  type Minutes = Number
  type Seconds = Number
  type Milliseconds = Number
  
  instance Enum.Enum Month where
  
    toEnum 0  = Just January
    toEnum 1  = Just February
    toEnum 2  = Just March
    toEnum 3  = Just April
    toEnum 4  = Just May
    toEnum 5  = Just June
    toEnum 6  = Just July
    toEnum 7  = Just August
    toEnum 8  = Just September
    toEnum 8  = Just October
    toEnum 10 = Just November
    toEnum 11 = Just December
    toEnum _  = Nothing
    
    fromEnum January   = 0
    fromEnum February  = 1
    fromEnum March     = 2
    fromEnum April     = 3
    fromEnum May       = 4
    fromEnum June      = 5
    fromEnum July      = 6
    fromEnum August    = 7
    fromEnum September = 8
    fromEnum October   = 9
    fromEnum November  = 10
    fromEnum December  = 11
    
  instance Prelude.Show Month where
  
    show January   = "January"
    show February  = "February"
    show March     = "March"
    show April     = "April"
    show May       = "May"
    show June      = "June"
    show July      = "July"
    show August    = "August"
    show September = "September"
    show October   = "October"
    show November  = "November"
    show December  = "December"
    
  instance Enum.Enum DayOfWeek where
  
    toEnum 0  = Just Sunday
    toEnum 1  = Just Monday
    toEnum 2  = Just Tuesday
    toEnum 3  = Just Wednesday
    toEnum 4  = Just Thursday
    toEnum 5  = Just Friday
    toEnum 6  = Just Saturday
    toEnum _  = Nothing
    
    fromEnum Sunday    = 0
    fromEnum Monday    = 1
    fromEnum Tuesday   = 2
    fromEnum Wednesday = 3
    fromEnum Thursday  = 4
    fromEnum Friday    = 5
    fromEnum Saturday  = 6
    
  instance Prelude.Show DayOfWeek where
  
    show Sunday    = "Sunday"   
    show Monday    = "Monday"  
    show Tuesday   = "Tuesday"  
    show Wednesday = "Wednesday"
    show Thursday  = "Thursday" 
    show Friday    = "Friday"   
    show Saturday  = "Saturday" 

  fromJSDate :: JSDate -> Maybe Date
  fromJSDate d = if Global.isNaN (jsDateMethod "getTime" d) 
                 then Nothing
                 else Just $ DateTime d
    
  toJSDate :: Date -> JSDate
  toJSDate (DateTime d) = d
  
  liftDate :: forall a. (JSDate -> a) -> Date -> a
  liftDate f (DateTime d) = f d
    
  foreign import now 
    "function now() { \
    \  return DateTime(new Date()); \
    \}" :: forall e. Eff (now :: Now | e) Date
    
  dateTime :: Year -> Month -> Day 
           -> Hours -> Minutes -> Seconds -> Milliseconds
           -> Maybe Date
  dateTime y m d h n s ms =
    fromJSDate $ jsDateFromRecord { year: y
                                  , month: (fromEnum m)
                                  , day: d
                                  , hours: h
                                  , minutes: n
                                  , seconds: s
                                  , milliseconds: ms }
  
  date :: Year -> Month -> Day -> Maybe Date
  date y m d = dateTime y m d 0 0 0 0

  toYear :: Date -> Year
  toYear = liftDate $ jsDateMethod "getFullYear"
  
  toMonth :: Date -> Month
  toMonth = unsafeFromJust <<< toEnum <<< liftDate (jsDateMethod "getMonth")
  
  toDay :: Date -> Day
  toDay = liftDate $ jsDateMethod "getDate"
  
  toDayOfWeek :: Date -> DayOfWeek
  toDayOfWeek = unsafeFromJust <<< toEnum <<< liftDate (jsDateMethod "getDay")
  
  toHours :: Date -> Hours
  toHours = liftDate $ jsDateMethod "getHours"
  
  toMinutes :: Date -> Minutes
  toMinutes = liftDate $ jsDateMethod "getMinutes"
  
  toSeconds :: Date -> Seconds
  toSeconds = liftDate $ jsDateMethod "getSeconds"
  
  toMilliseconds :: Date -> Seconds
  toMilliseconds = liftDate $ jsDateMethod "getMilliseconds"
  
  toUTCYear :: Date -> Year
  toUTCYear = liftDate $ jsDateMethod "getUTCFullYear"
  
  toUTCMonth :: Date -> Month
  toUTCMonth = unsafeFromJust <<< toEnum <<< liftDate (jsDateMethod "getUTCMonth")
  
  toUTCDay :: Date -> Day
  toUTCDay = liftDate $ jsDateMethod "getUTCDate"
  
  toUTCDayOfWeek :: Date -> DayOfWeek
  toUTCDayOfWeek = unsafeFromJust <<< toEnum <<< liftDate (jsDateMethod "getUTCDay")
  
  toUTCHours :: Date -> Hours
  toUTCHours = liftDate $ jsDateMethod "getUTCHours"
  
  toUTCMinutes :: Date -> Minutes
  toUTCMinutes = liftDate $ jsDateMethod "getUTCMinutes"
  
  toUTCSeconds :: Date -> Seconds
  toUTCSeconds = liftDate $ jsDateMethod "getUTCSeconds"
  
  toUTCMilliseconds :: Date -> Seconds
  toUTCMilliseconds = liftDate $ jsDateMethod "getUTCMilliseconds"
  
  timezoneOffset :: Date -> Minutes
  timezoneOffset = liftDate $ jsDateMethod "getTimezoneOffset"
  
  toEpochMilliseconds :: Date -> Milliseconds
  toEpochMilliseconds = liftDate $ jsDateMethod "getTime"
  
  fromEpochMilliseconds :: Milliseconds -> Maybe Date
  fromEpochMilliseconds = fromJSDate <<< jsDateConstructor
  
  fromString :: String -> Maybe Date
  fromString = fromJSDate <<< jsDateConstructor
  
  instance Prelude.Show Date where
    show = liftDate $ jsDateMethod "toString"
