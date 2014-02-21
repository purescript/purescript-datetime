module Main where

import Prelude
import Data.Date
import Data.Maybe
import Control.Monad.Eff
import Debug.Trace

foreign import testJSDateOk "var testJSDateOk = new Date();" :: JSDate
foreign import testJSDateBad "var testJSDateBad = new Date('fail');" :: JSDate

main = do
  d <- now
  print d
  
  print $ fromJSDate testJSDateOk
  print $ fromJSDate testJSDateBad
  
  print $ fromString "Tue Feb 18 2014 23:24:53 GMT+3000"
  print $ date 2003 January 01
  print $ dateTime 2044 February 01 13 26 48 06
  
  print $ toYear d
  print $ toMonth d
  print $ toDay d
  print $ toHours d
  print $ toMinutes d
  print $ toSeconds d
  print $ toMilliseconds d
  
  print $ toUTCYear d
  print $ toUTCMonth d
  print $ toUTCDay d
  print $ toUTCHours d
  print $ toUTCMinutes d
  print $ toUTCSeconds d
  print $ toUTCMilliseconds d
  
  print $ timezoneOffset d
  print $ toEpochMilliseconds d
  
  print $ fromEpochMilliseconds 0
  print $ fromEpochMilliseconds 999999999999
  print $ fromEpochMilliseconds (0-999999999999)
  
  print $ (unsafeFromJust (date 2003 January 01)) < d
  print $ d == d
