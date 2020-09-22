module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Test.Date (dateTests)
import Test.DateTime (dateTimeTests)
import Test.Duration (durationTests)
import Test.Instant (instantTests)
import Test.Time (timeTests)

----------------------------------------------------------------------------------------------
-- 20.4.1.2 Day Number and Time within Day
----------------------------------------------------------------------------------------------
-- Day(t) = floor(t / msPerDay)
-- msPerDay = 86400000
--
-- The remainder is called the time within the day:
-- TimeWithinDay(t) = t modulo msPerDay

----------------------------------------------------------------------------------------------
-- 20.4.1.3 Year Number
----------------------------------------------------------------------------------------------
-- DaysInYear(y)
--   = 365 if (y modulo 4) ≠ 0
--   = 366 if (y modulo 4) = 0 and (y modulo 100) ≠ 0
--   = 365 if (y modulo 100) = 0 and (y modulo 400) ≠ 0
--   = 366 if (y modulo 400) = 0
--
-- All non-leap years have 365 days with the usual number of days per month and leap years have an extra day in February.
-- The day number of the first day of year y is given by:
-- DayFromYear(y) = 365 × (y - 1970) + floor((y - 1969) / 4) - floor((y - 1901) / 100) + floor((y - 1601) / 400)
--
-- The time value of the start of a year is:
-- TimeFromYear(y) = msPerDay × DayFromYear(y)
-- YearFromTime(t) = the largest integer y (closest to positive infinity) such that TimeFromYear(y) ≤ t
--
-- InLeapYear(t)
--   = 0 if DaysInYear(YearFromTime(t)) = 365
--   = 1 if DaysInYear(YearFromTime(t)) = 366
--
-- MonthFromTime(t)
--   = 0 if 0 ≤ DayWithinYear(t) < 31
--   = 1 if 31 ≤ DayWithinYear(t) < 59 + InLeapYear(t)
--   = 2 if 59 + InLeapYear(t) ≤ DayWithinYear(t) < 90 + InLeapYear(t)
--   = 3 if 90 + InLeapYear(t) ≤ DayWithinYear(t) < 120 + InLeapYear(t)
--   = 4 if 120 + InLeapYear(t) ≤ DayWithinYear(t) < 151 + InLeapYear(t)
--   = 5 if 151 + InLeapYear(t) ≤ DayWithinYear(t) < 181 + InLeapYear(t)
--   = 6 if 181 + InLeapYear(t) ≤ DayWithinYear(t) < 212 + InLeapYear(t)
--   = 7 if 212 + InLeapYear(t) ≤ DayWithinYear(t) < 243 + InLeapYear(t)
--   = 8 if 243 + InLeapYear(t) ≤ DayWithinYear(t) < 273 + InLeapYear(t)
--   = 9 if 273 + InLeapYear(t) ≤ DayWithinYear(t) < 304 + InLeapYear(t)
--   = 10 if 304 + InLeapYear(t) ≤ DayWithinYear(t) < 334 + InLeapYear(t)
--   = 11 if 334 + InLeapYear(t) ≤ DayWithinYear(t) < 365 + InLeapYear(t)
--
-- DayWithinYear(t) = Day(t) - DayFromYear(YearFromTime(t))
-- Note that MonthFromTime(0) = 0, corresponding to Thursday, 01 January, 1970.

----------------------------------------------------------------------------------------------
-- 20.4.1.5 Date Number
----------------------------------------------------------------------------------------------
-- DateFromTime(t)
--   = DayWithinYear(t) + 1 if MonthFromTime(t) = 0
--   = DayWithinYear(t) - 30 if MonthFromTime(t) = 1
--   = DayWithinYear(t) - 58 - InLeapYear(t) if MonthFromTime(t) = 2
--   = DayWithinYear(t) - 89 - InLeapYear(t) if MonthFromTime(t) = 3
--   = DayWithinYear(t) - 119 - InLeapYear(t) if MonthFromTime(t) = 4
--   = DayWithinYear(t) - 150 - InLeapYear(t) if MonthFromTime(t) = 5
--   = DayWithinYear(t) - 180 - InLeapYear(t) if MonthFromTime(t) = 6
--   = DayWithinYear(t) - 211 - InLeapYear(t) if MonthFromTime(t) = 7
--   = DayWithinYear(t) - 242 - InLeapYear(t) if MonthFromTime(t) = 8
--   = DayWithinYear(t) - 272 - InLeapYear(t) if MonthFromTime(t) = 9
--   = DayWithinYear(t) - 303 - InLeapYear(t) if MonthFromTime(t) = 10
--   = DayWithinYear(t) - 333 - InLeapYear(t) if MonthFromTime(t) = 11

----------------------------------------------------------------------------------------------
-- 20.4.1.6 Week Day
----------------------------------------------------------------------------------------------
-- WeekDay(t) = (Day(t) + 4) modulo 7
-- A weekday value of
--   0 specifies Sunday;
--   1 specifies Monday;
--   2 specifies Tuesday;
--   3 specifies Wednesday;
--   4 specifies Thursday;
--   5 specifies Friday;
--   6 specifies Saturday.
--   Note that WeekDay(0) = 4, corresponding to Thursday, 01 January, 1970.

----------------------------------------------------------------------------------------------
-- 20.4.1.7 LocalTZA ( t, isUTC )  ???
----------------------------------------------------------------------------------------------
-- https://tc39.es/ecma262/#sec-local-time-zone-adjustment
-- returns the local time zone adjustment, or offset, in milliseconds
-- LocalTZA( t :: UTC, true )    = should return the offset of the local time zone from UTC measured in milliseconds
--                                 at time represented by time value t :: UTC. When the result is added to t :: UTC, it should yield
--                                 the corresponding Number t :: local.
-- LocalTZA( t :: local, false ) = should return the offset of the local time zone from UTC measured in
--                                 milliseconds at local time represented by Number tlocal.
--                                 When the result is subtracted from t :: local, it should yield the corresponding
--                                 time value t :: UTC.

----------------------------------------------------------------------------------------------
-- 20.4.1.8 LocalTime ( t )
----------------------------------------------------------------------------------------------
-- Return t + LocalTZA(t, true)

----------------------------------------------------------------------------------------------
-- 20.4.1.9 UTC ( t )
----------------------------------------------------------------------------------------------
-- Return t - LocalTZA(t, false).

----------------------------------------------------------------------------------------------
-- 20.4.1.10 Hours, Minutes, Second, and Milliseconds
----------------------------------------------------------------------------------------------
-- HourFromTime(t) = floor(t / msPerHour) modulo HoursPerDay
-- MinFromTime(t) = floor(t / msPerMinute) modulo MinutesPerHour
-- SecFromTime(t) = floor(t / msPerSecond) modulo SecondsPerMinute
-- msFromTime(t) = t modulo msPerSecond
--
-- HoursPerDay = 24
-- MinutesPerHour = 60
-- SecondsPerMinute = 60
-- msPerSecond = 1000
-- msPerMinute = 60000 = msPerSecond × SecondsPerMinute
-- msPerHour = 3600000 = msPerMinute × MinutesPerHour

----------------------------------------------------------------------------------------------
-- 20.4.1.11 MakeTime ( hour, min, sec, ms )
----------------------------------------------------------------------------------------------
-- If hour is not finite or min is not finite or sec is not finite or ms is not finite, return NaN.
-- h = ! ToInteger(hour).
-- m = ! ToInteger(min).
-- s = ! ToInteger(sec).
-- milli = ! ToInteger(ms).
-- t = h * msPerHour + m * msPerMinute + s * msPerSecond + milli
--         (performing the arithmetic according to IEEE 754-2019 rules (that is, as if using the ECMAScript operators * and +))
-- Return t.

----------------------------------------------------------------------------------------------
-- 20.4.1.12 MakeDay ( year, month, date )
----------------------------------------------------------------------------------------------
-- If year is not finite or month is not finite or date is not finite, return NaN.
-- y = ! ToInteger(year).
-- m = ! ToInteger(month).
-- dt = ! ToInteger(date).
-- ym = y + floor(m / 12).
-- mn = m modulo 12.
--  Find a value t such that YearFromTime(t) is ym and MonthFromTime(t) is mn and DateFromTime(t) is 1;
--  but if this is not possible (because some argument is out of range), return NaN.
-- Return Day(t) + dt - 1.

----------------------------------------------------------------------------------------------
-- 20.4.1.13 MakeDate ( day, time )
----------------------------------------------------------------------------------------------
-- If day is not finite or time is not finite, return NaN.
-- Return day × msPerDay + time.

----------------------------------------------------------------------------------------------
-- 20.4.1.14 TimeClip ( time )
----------------------------------------------------------------------------------------------
-- If time is not finite, return NaN.
-- If abs(time) > 8.64 × 10^15, return NaN.
-- Return ! ToInteger(time).

----------------------------------------------------------------------------------------------
-- 20.4.1.15 Date Time String Format
----------------------------------------------------------------------------------------------
-- YYYY-MM-DDTHH:mm:ss.sssZ
-- ISO 8601 calendar date extended format.

----------------------------------------------------------------------------------------------
-- 20.4.1.15.1 Expanded Years
----------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------
-- 20.4.2.1 Date ( year, month [ , date [ , hours [ , minutes [ , seconds [ , ms ] ] ] ] ] )
----------------------------------------------------------------------------------------------
-- If NewTarget is undefined, then
--   Let `now` be the Number that is the time value (UTC) identifying the current time.
--   Return ToDateString(now).
-- Else
--   y = ToNumber(year).
--   m = ToNumber(month).
--   If date is present, let dt be ? ToNumber(date); else let dt be 1.
--   If hours is present, let h be ? ToNumber(hours); else let h be 0.
--   If minutes is present, let min be ? ToNumber(minutes); else let min be 0.
--   If seconds is present, let s be ? ToNumber(seconds); else let s be 0.
--   If ms is present, let milli be ? ToNumber(ms); else let milli be 0.
--   If y is NaN, let yr be NaN.
--   Else,
--     Let yi be ! ToInteger(y).
--     If 0 ≤ yi ≤ 99, let yr be 1900 + yi; otherwise, let yr be y.
--   finalDate = MakeDate(MakeDay(yr, m, dt), MakeTime(h, min, s, milli)).
--   O = OrdinaryCreateFromConstructor(NewTarget, "%Date.prototype%", « [[DateValue]] »).
--   Set O.[[DateValue]] to TimeClip(UTC(finalDate)).
--   Return O.

----------------------------------------------------------------------------------------------
-- 20.4.3.4 Date.UTC ( year [ , month [ , date [ , hours [ , minutes [ , seconds [ , ms ] ] ] ] ] ] )
----------------------------------------------------------------------------------------------
-- y = ToNumber(year).
-- If month is present    then m = ToNumber(month); else m = 0.
-- If date is present,    then dt = ToNumber(date); else dt = 1.
-- If hours is present,   then h = ToNumber(hours); else h = 0.
-- If minutes is present, then min = ToNumber(minutes); min = 0.
-- If seconds is present, then s = ToNumber(seconds); else s = 0.
-- If ms is present,      then milli = ToNumber(ms); else milli = 0.
-- If y is NaN, let yr be NaN.
--   Else,
--     Let yi be ! ToInteger(y).
--     If 0 ≤ yi ≤ 99,
--       then yr = 1900 + yi;
--       otherwise, yr = y.
-- Return TimeClip(MakeDate(MakeDay(yr, m, dt), MakeTime(h, min, s, milli))).

----------------------------------------------------------------------------------------------
-- 20.4.4.2 getDate ( )
----------------------------------------------------------------------------------------------
-- t = thisTimeValue(this value).
-- If t is NaN, return NaN.
-- Return DateFromTime(LocalTime(t)).

----------------------------------------------------------------------------------------------
-- 20.4.4.3 getDay ( )
----------------------------------------------------------------------------------------------
-- Return WeekDay(LocalTime(t)).

----------------------------------------------------------------------------------------------
-- 20.4.4.4 getFullYear ( )
----------------------------------------------------------------------------------------------
-- Return YearFromTime(LocalTime(t)).

----------------------------------------------------------------------------------------------
-- 20.4.4.5 getHours ( )
----------------------------------------------------------------------------------------------
-- Return HourFromTime(LocalTime(t)).

----------------------------------------------------------------------------------------------
-- 20.4.4.6 getMilliseconds ( )
----------------------------------------------------------------------------------------------
-- Return msFromTime(LocalTime(t)).

----------------------------------------------------------------------------------------------
-- 20.4.4.7 getMinutes ( )
----------------------------------------------------------------------------------------------
-- Return MinFromTime(LocalTime(t))

----------------------------------------------------------------------------------------------
-- 20.4.4.7 getMonth ( )
----------------------------------------------------------------------------------------------
-- Return MonthFromTime(LocalTime(t))

----------------------------------------------------------------------------------------------
-- 20.4.4.9 getSeconds ( )
----------------------------------------------------------------------------------------------
-- Return SecFromTime(LocalTime(t)).

----------------------------------------------------------------------------------------------
-- 20.4.4.10 getTime ( )
----------------------------------------------------------------------------------------------
-- Return ? thisTimeValue(this value).

----------------------------------------------------------------------------------------------
-- 20.4.4.11 getTimezoneOffset ( )
----------------------------------------------------------------------------------------------
-- Return (t - LocalTime(t)) / msPerMinute.

----------------------------------------------------------------------------------------------
-- 20.4.4.12 getUTCDate ( )
----------------------------------------------------------------------------------------------
-- Return DateFromTime(t).

----------------------------------------------------------------------------------------------
-- 20.4.4.13 getUTCDay ( )
----------------------------------------------------------------------------------------------
-- Return WeekDay(t).

----------------------------------------------------------------------------------------------
-- 20.4.4.14 getUTCFullYear ( )
----------------------------------------------------------------------------------------------
-- Return YearFromTime(t).

----------------------------------------------------------------------------------------------
-- 20.4.4.15 getUTCHours ( )
----------------------------------------------------------------------------------------------
-- Return HourFromTime(t)

----------------------------------------------------------------------------------------------
-- 20.4.4.16 getUTCMilliseconds ( )
----------------------------------------------------------------------------------------------
-- Return msFromTime(t).

----------------------------------------------------------------------------------------------
-- 20.4.4.17 getUTCMinutes ( )
----------------------------------------------------------------------------------------------
-- Return MinFromTime(t).

----------------------------------------------------------------------------------------------
-- 20.4.4.18 getUTCMonth ( )
----------------------------------------------------------------------------------------------
-- Return MonthFromTime(t).

----------------------------------------------------------------------------------------------
-- 20.4.4.19 getUTCSeconds ( )
----------------------------------------------------------------------------------------------
-- Return SecFromTime(t).

----------------------------------------------------------------------------------------------
-- 20.4.4.20 setDate ( date )
----------------------------------------------------------------------------------------------
-- t = LocalTime(thisTimeValue(this value)).
-- dt = ToNumber(date).
-- newDate = MakeDate(MakeDay(YearFromTime(t), MonthFromTime(t), dt), TimeWithinDay(t)).
-- u = TimeClip(UTC(newDate)).
-- Set the [[DateValue]] internal slot of this Date object to u.
-- Return u.

----------------------------------------------------------------------------------------------
-- 20.4.4.21 setFullYear ( year [ , month [ , date ] ] )
----------------------------------------------------------------------------------------------
-- t = thisTimeValue(this value).
-- If t is NaN, set t to +0; otherwise, set t to LocalTime(t).
-- y = ToNumber(year).
-- If month is not present, m = MonthFromTime(t); otherwise, m  = ToNumber(month).
-- If date is not present,  dt = DateFromTime(t); otherwise, dt = ToNumber(date).
-- newDate = MakeDate(MakeDay(y, m, dt), TimeWithinDay(t)).
-- u = TimeClip(UTC(newDate)).
-- Set the [[DateValue]] internal slot of this Date object to u.
-- Return u.

----------------------------------------------------------------------------------------------
-- 20.4.4.22 setHours ( hour [ , min [ , sec [ , ms ] ] ] )
----------------------------------------------------------------------------------------------
-- t = LocalTime(thisTimeValue(this value)).
-- h = ToNumber(hour).
-- If min is not present, m = MinFromTime(t); otherwise, m = ToNumber(min).
-- If sec is not present, s = SecFromTime(t); otherwise, s = ToNumber(sec).
-- If ms is not present, milli = msFromTime(t); otherwise, milli = ToNumber(ms).
-- date = MakeDate(Day(t), MakeTime(h, m, s, milli)).
-- u = TimeClip(UTC(date)).
-- Set the [[DateValue]] internal slot of this Date object to u.
-- Return u.

-- got bored can refer to them if implementing functions !!

main :: Effect Unit
main = do
  durationTests
  timeTests
  dateTests
  dateTimeTests
  instantTests
  log "All tests done"
