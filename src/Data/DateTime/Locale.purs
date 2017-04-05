module Data.DateTime.Locale where

import Prelude
import Control.Comonad (class Comonad, class Extend)
import Data.DateTime (Date, Time, DateTime)
import Data.Foldable (class Foldable)
import Data.Generic (class Generic)
import Data.Maybe (Maybe)
import Data.Newtype (class Newtype)
import Data.Time.Duration (Minutes)
import Data.Traversable (class Traversable, traverse)

-- | A date/time locale specifying an offset in minutes and an optional name for
-- | the locale.
data Locale = Locale (Maybe LocaleName) Minutes

derive instance eqLocale :: Eq Locale
derive instance ordLocale :: Ord Locale
derive instance genericLocale :: Generic Locale

instance showLocale :: Show Locale where
  show (Locale name offset) = "(Locale " <> show name <> " " <> show offset <> ")"

-- | The name of a date/time locale. For example: "GMT", "MDT", "CET", etc.
newtype LocaleName = LocaleName String

derive instance newtypeLocaleName :: Newtype LocaleName _
derive newtype instance eqLocaleName :: Eq LocaleName
derive newtype instance ordLocaleName :: Ord LocaleName
derive instance genericLocaleName :: Generic LocaleName

instance showLocaleName :: Show LocaleName where
  show (LocaleName name) = "(LocaleName " <> show name <> ")"

-- | A value that is subject to a `Locale`.
-- |
-- | There are `Functor`, `Extend`, and `Comonad` instances for `LocalValue` to
-- | enable the inner non-localised value to be manipulated while maintaining
-- | the locale.
data LocalValue a = LocalValue Locale a

derive instance eqLocalValue :: Eq a => Eq (LocalValue a)
derive instance ordLocalValue :: Ord a => Ord (LocalValue a)
derive instance genericLocalValue :: Generic a => Generic (LocalValue a)

instance showLocalValue :: Show a => Show (LocalValue a) where
  show (LocalValue n a) = "(LocalValue " <> show n <> " " <> show a <> ")"

instance functorLocalValue :: Functor LocalValue where
  map f (LocalValue n a) = LocalValue n (f a)

instance extendLocalValue :: Extend LocalValue where
  extend f lv@(LocalValue n _) = LocalValue n (f lv)

instance comonadLocalValue :: Comonad LocalValue where
  extract (LocalValue _ a) = a

instance foldableLocalValue :: Foldable LocalValue where
  foldl f b (LocalValue _ a) = f b a
  foldr f b (LocalValue _ a) = f a b
  foldMap f (LocalValue _ a) = f a

instance traversableLocalValue :: Traversable LocalValue where
  traverse f (LocalValue n a) = LocalValue <$> pure n <*> f a
  sequence = traverse id

-- | A date value with a locale.
type LocalDate = LocalValue Date

-- | A time value with a locale.
type LocalTime = LocalValue Time

-- | A date/time value with a locale.
type LocalDateTime = LocalValue DateTime
