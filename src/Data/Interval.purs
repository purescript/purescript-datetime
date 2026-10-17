module Data.Interval
  ( Interval(..)
  , RecurringInterval(..)
  , module Exports
  ) where

import Prelude

import Control.Extend (class Extend, extend)
import Data.Bifoldable (class Bifoldable, bifoldMapDefaultL, bifoldl, bifoldr, bifoldrDefault)
import Data.Bifunctor (class Bifunctor, bimap)
import Data.Bitraversable (class Bitraversable, bisequenceDefault, bitraverse)
import Data.Foldable (class Foldable, foldMapDefaultL, foldl, foldr, foldrDefault)
import Data.Interval.Duration (Duration(..), DurationComponent(..), day, hour, millisecond, minute, month, second, week, year) as Exports
import Data.Maybe (Maybe)
import Data.Traversable (class Traversable, sequenceDefault, traverse)

data RecurringInterval d a = RecurringInterval (Maybe Int) (Interval d a)

derive instance eqRecurringInterval :: (Eq d, Eq a) => Eq (RecurringInterval d a)
derive instance ordRecurringInterval :: (Ord d, Ord a) => Ord (RecurringInterval d a)
instance showRecurringInterval :: (Show d, Show a) => Show (RecurringInterval d a) where
  show (RecurringInterval x y) = "(RecurringInterval " <> show x <> " " <> show y <> ")"

interval :: forall d a. RecurringInterval d a -> Interval d a
interval (RecurringInterval _ i) = i

over :: forall f d a d' a'. Functor f => (Interval d a -> f (Interval d' a')) -> RecurringInterval d a -> f (RecurringInterval d' a')
over f (RecurringInterval n i) = map (RecurringInterval n) (f i)

instance functorRecurringInterval :: Functor (RecurringInterval d) where
  map f (RecurringInterval n i) = RecurringInterval n (map f i)

instance bifunctorRecurringInterval :: Bifunctor RecurringInterval where
  bimap f g (RecurringInterval n i) = RecurringInterval n (bimap f g i)

instance foldableRecurringInterval :: Foldable (RecurringInterval d) where
  foldl f i = foldl f i <<< interval
  foldr f i = foldr f i <<< interval
  foldMap = foldMapDefaultL

instance bifoldableRecurringInterval :: Bifoldable RecurringInterval where
  bifoldl f g i = bifoldl f g i <<< interval
  bifoldr f g i = bifoldr f g i <<< interval
  bifoldMap = bifoldMapDefaultL

instance traversableRecurringInterval :: Traversable (RecurringInterval d) where
  traverse f i = traverse f `over` i
  sequence = sequenceDefault

instance bitraversableRecurringInterval :: Bitraversable RecurringInterval where
  bitraverse l r i = bitraverse l r `over` i
  bisequence = bisequenceDefault

instance extendRecurringInterval :: Extend (RecurringInterval d) where
  extend f a@(RecurringInterval n i) = RecurringInterval n (extend (const (f a)) i)

data Interval d a
  = StartEnd a a
  | DurationEnd d a
  | StartDuration a d
  | DurationOnly d

derive instance eqInterval :: (Eq d, Eq a) => Eq (Interval d a)
derive instance ordInterval :: (Ord d, Ord a) => Ord (Interval d a)
instance showInterval :: (Show d, Show a) => Show (Interval d a) where
  show = case _ of
    StartEnd x y -> "(StartEnd " <> show x <> " " <> show y <> ")"
    DurationEnd d x -> "(DurationEnd " <> show d <> " " <> show x <> ")"
    StartDuration x d -> "(StartDuration " <> show x <> " " <> show d <> ")"
    DurationOnly d -> "(DurationOnly " <> show d <> ")"

instance functorInterval :: Functor (Interval d) where
  map = bimap identity

instance bifunctorInterval :: Bifunctor Interval where
  bimap g f = case _ of
    StartEnd x y -> StartEnd (f x) (f y)
    DurationEnd d x -> DurationEnd (g d) (f x)
    StartDuration x d -> StartDuration (f x) (g d)
    DurationOnly d -> DurationOnly (g d)

instance foldableInterval :: Foldable (Interval d) where
  foldl f z = case _ of
    StartEnd x y -> (z `f` x) `f` y
    DurationEnd _ x -> z `f` x
    StartDuration x _ -> z `f` x
    _ -> z
  foldr x = foldrDefault x
  foldMap = foldMapDefaultL

instance bifoldableInterval :: Bifoldable Interval where
  bifoldl g f z = case _ of
    StartEnd x y -> (z `f` x) `f` y
    DurationEnd d x -> (z `g` d) `f` x
    StartDuration x d -> (z `g` d) `f` x
    DurationOnly d -> z `g` d
  bifoldr x = bifoldrDefault x
  bifoldMap = bifoldMapDefaultL

instance traversableInterval :: Traversable (Interval d) where
  traverse f = case _ of
    StartEnd x y -> StartEnd <$> f x <*> f y
    DurationEnd d x -> f x <#> DurationEnd d
    StartDuration x d -> f x <#> (_ `StartDuration` d)
    DurationOnly d -> pure (DurationOnly d)
  sequence = sequenceDefault

instance bitraversableInterval :: Bitraversable Interval where
  bitraverse l r = case _ of
    StartEnd x y -> StartEnd <$> r x <*> r y
    DurationEnd d x -> DurationEnd <$> l d <*> r x
    StartDuration x d -> StartDuration <$> r x <*> l d
    DurationOnly d -> DurationOnly <$> l d
  bisequence = bisequenceDefault

instance extendInterval :: Extend (Interval d) where
  extend f a = case a of
    StartEnd _ _ -> StartEnd (f a) (f a)
    DurationEnd d _ -> DurationEnd d (f a)
    StartDuration _ d -> StartDuration (f a) d
    DurationOnly d -> DurationOnly d
