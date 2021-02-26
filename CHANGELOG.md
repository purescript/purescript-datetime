# Changelog

Notable changes to this project are documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Breaking changes:

New features:

Bugfixes:

Other improvements:

## [v5.0.0](https://github.com/purescript/purescript-datetime/releases/tag/v5.0.0) - 2021-02-26

Breaking changes:
  - Added support for PureScript 0.14 and dropped support for all previous versions (#81)

New features:

Bugfixes:
- Fixed `genDate` generator frequency (#83)

Other improvements:
  - Migrated CI to GitHub Actions and updated installation instructions to use Spago (#82)
  - Added a CHANGELOG.md file and pull request template (#84, #85)

## [v4.1.1](https://github.com/purescript/purescript-datetime/releases/tag/v4.1.1) - 2019-02-09

Fixed minimum bound on `toEnum` for `Year` (@bouzuya)

## [v4.1.0](https://github.com/purescript/purescript-datetime/releases/tag/v4.1.0) - 2018-10-25

Adds an `adjust` function to change a date by a specified duration of days

## [v4.0.0](https://github.com/purescript/purescript-datetime/releases/tag/v4.0.0) - 2018-05-24

- Updated for PureScript 0.12
- Removed `Locale` - it was a glorified `Tuple` without any useful extra functionality
- Duration values no longer implement `Ring` and `Semiring`, but now have `Semiring` and `Monoid` instances and a `negateDuration` function

## [v3.4.1](https://github.com/purescript/purescript-datetime/releases/tag/v3.4.1) - 2017-11-04

- Fix for pursuit auto-publishing

## [v3.4.0](https://github.com/purescript/purescript-datetime/releases/tag/v3.4.0) - 2017-09-22

- Export `fromDate` for `Instant` (@javcasas)

## [v3.3.0](https://github.com/purescript/purescript-datetime/releases/tag/v3.3.0) - 2017-06-26

- Added types for intervals (@safareli)

## [v3.2.0](https://github.com/purescript/purescript-datetime/releases/tag/v3.2.0) - 2017-06-08

- Added generators for date/time types

## [v3.1.0](https://github.com/purescript/purescript-datetime/releases/tag/v3.1.0) - 2017-06-04

- Added `lastDayOfMonth` (@MichaelXavier)

## [v3.0.0](https://github.com/purescript/purescript-datetime/releases/tag/v3.0.0) - 2017-03-27

- Updated for PureScript 0.11

## [v2.2.0](https://github.com/purescript/purescript-datetime/releases/tag/v2.2.0) - 2017-03-13

- Added functions to modify just the date or time component of a `DateTime`

## [v2.1.1](https://github.com/purescript/purescript-datetime/releases/tag/v2.1.1) - 2017-03-08

- Fixed behaviour of `diff` for `Date` types

## [v2.1.0](https://github.com/purescript/purescript-datetime/releases/tag/v2.1.0) - 2017-02-14

- Added `isLeapYear` predicate function (@MichaelXavier)

## [v2.0.0](https://github.com/purescript/purescript-datetime/releases/tag/v2.0.0) - 2016-10-13

- Updated dependencies

## [v1.0.0](https://github.com/purescript/purescript-datetime/releases/tag/v1.0.0) - 2016-06-09

This release is intended for the PureScript 0.9.1 compiler and newer.

The library has been redesigned, and now no longer provides a type for the JavaScript `Date` object or the ability to fetch the current time, these are now provided by [`purescript-js-date`](https://github.com/purescript-contrib/purescript-js-date) and [`purescript-now`](https://github.com/purescript-contrib/purescript-now) libraries.

**Note**: The v1.0.0 tag is not meant to indicate the library is “finished”, the core libraries are all being bumped to this for the 0.9 compiler release so as to use semver more correctly.

## [v0.9.2](https://github.com/purescript/purescript-datetime/releases/tag/v0.9.2) - 2016-04-05

- Added `toISOString` (@parsonsmatt)

## [v0.9.1](https://github.com/purescript/purescript-datetime/releases/tag/v0.9.1) - 2015-11-20

- Removed unused import (@tfausak)

## [v0.9.0](https://github.com/purescript/purescript-datetime/releases/tag/v0.9.0) - 2015-08-13

- Updated dependencies

## [v0.8.0](https://github.com/purescript/purescript-datetime/releases/tag/v0.8.0) - 2015-08-02

- Updated dependencies

## [v0.7.0](https://github.com/purescript/purescript-datetime/releases/tag/v0.7.0) - 2015-07-25

- Fixed time values (`Hours`, `Minutes`, `Seconds`, `Milliseconds`) by changing the internal representation to `Number`. Previously `Milliseconds` would overflow when using functions like `toEpochMilliseconds`. (@nwolverson)

## [v0.6.0](https://github.com/purescript/purescript-datetime/releases/tag/v0.6.0) - 2015-06-30

This release works with versions 0.7.\* of the PureScript compiler. It will not work with older versions. If you are using an older version, you should require an older, compatible version of this library.

## [v0.6.0-rc.1](https://github.com/purescript/purescript-datetime/releases/tag/v0.6.0-rc.1) - 2015-06-14

Initial release candidate of the library intended for the 0.7 compiler.

## [v0.5.3](https://github.com/purescript/purescript-datetime/releases/tag/v0.5.3) - 2015-05-22

- Added `toLocaleString` and variants (@hdgarrood)

## [v0.5.2](https://github.com/purescript/purescript-datetime/releases/tag/v0.5.2) - 2015-04-13

- Fixed bug with exceptions being thrown when attempting to use members of the UTC module #14 (@bkyrlach)

## [v0.5.1](https://github.com/purescript/purescript-datetime/releases/tag/v0.5.1) - 2015-04-08

- Fixed methods in `Locale` to not call the `UTC` variants #11

## [v0.5.0](https://github.com/purescript/purescript-datetime/releases/tag/v0.5.0) - 2015-04-06

- Update dependencies

## [v0.4.0](https://github.com/purescript/purescript-datetime/releases/tag/v0.4.0) - 2015-03-28

- Library has been redesigned for better safety
- UTC dates can now be constructed
- The current time in milliseconds since the unix epoch can now be fetched without having to construct a date

## [v0.3.1](https://github.com/purescript/purescript-datetime/releases/tag/v0.3.1) - 2015-03-01

- Days of the week are now exported (@nwolverson)

## [v0.3.0](https://github.com/purescript/purescript-datetime/releases/tag/v0.3.0) - 2015-02-21

**This release requires PureScript v0.6.8 or later**
- Updated dependencies

## [v0.2.0](https://github.com/purescript/purescript-datetime/releases/tag/v0.2.0) - 2015-01-11

- Updated for new `purescript-enum` (@philopon)

## [v0.1.2](https://github.com/purescript/purescript-datetime/releases/tag/v0.1.2) - 2014-12-15

- Fix `now` implementation (@Fresheyeball)

## [v0.1.1](https://github.com/purescript/purescript-datetime/releases/tag/v0.1.1) - 2014-11-24

Added `fromStringStrict` and updated dependencies (@jdegoes)

## [v0.1.0](https://github.com/purescript/purescript-datetime/releases/tag/v0.1.0) - 2014-10-14

- Added `Eq` and `Ord` instances for `DayOfWeek` and `Month`, update for new `Enum` (@jdegoes)

## [v0.0.1](https://github.com/purescript/purescript-datetime/releases/tag/v0.0.1) - 2014-10-14

Initial version release.

