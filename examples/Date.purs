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
  
  print $ year d
  print $ month d
  print $ day d
  print $ hour d
  print $ minute d
  print $ second d
  print $ millisecond d
  
  print $ yearUTC d
  print $ monthUTC d
  print $ dayUTC d
  print $ hourUTC d
  print $ minuteUTC d
  print $ secondUTC d
  print $ millisecondUTC d
  
  print $ timezoneOffset d
  print $ toEpochMilliseconds d
  
  print $ fromEpochMilliseconds 0
  print $ fromEpochMilliseconds 999999999999
  print $ fromEpochMilliseconds (0-999999999999)
  
  print $ pure (<) <*> (date 2003 January 01) <*> pure d
  print $ d == d
