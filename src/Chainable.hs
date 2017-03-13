-- |
-- Module      : Chainable
-- Description : Operators are meant to be chained
-- Copyright   : (c) Jonatan H Sundqvist, 2017
-- License     : MIT
-- Maintainer  : Jonatan H Sundqvist
-- Stability   : experimental
-- Portability : portable
--

-- TODO | -
--        -

-- SPEC | -
--        -

-- GHC Pragmas -----------------------------------------------------------------------------------------------------------------------------

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}

-- API -------------------------------------------------------------------------------------------------------------------------------------

module Chainable where

-- Definitions -------------------------------------------------------------------------------------------------------------------------------------

-- |
class VaryingArg a where {}


-- |
class VaryingFold a b c where
  fold :: (VaryingArg a, VaryingFold a b c) => (b -> a -> b) -> b -> c


-- |
instance (VaryingArg a, VaryingFold a b c) => VaryingFold a b ((->) a c) where
  fold f b a = fold f (f b a)


-- |
instance VaryingFold a b b where
  fold f acc = acc


-- |
instance VaryingArg Int
instance VaryingArg [Char]


-- |
-- TODO | - This class should be as flexible as possible
class Chainable a b c | b -> a where
  chainable :: (a -> a -> Bool) -> a -> b -> c


instance Chainable a a (a, Bool) where
  chainable f a b = (a, f a b)


instance Chainable a a Bool where
  chainable f a b = f a b


instance Chainable a (a, Bool) (a, Bool) where
  chainable f a (carried, previous) = (a, f a carried && previous)


instance Chainable a (a, Bool) Bool where
  chainable f a (carried, previous) = f a carried && previous

-- Chainable operators ---------------------------------------------------------------------------------------------------------------------

-- | Chainable equality
(=.) :: (Chainable a b c, Eq a) => a -> b -> c
(=.) = chainable (==)

-- | Chainable less-than
(<.) :: (Chainable a b c, Ord a) => a -> b -> c
(<.) = chainable (<)


-- | Chainable greater-than
(>.) :: (Chainable a b c, Ord a) => a -> b -> c
(>.) = chainable (>)


-- | Chainable less-or-equal
(≤) :: (Chainable a b c, Ord a) => a -> b -> c
(≤) = chainable (<=)


-- | Chainable greater-or-equal
(≥) :: (Chainable a b c, Ord a) => a -> b -> c
(≥) = chainable (>=)


-- TODO | - Decide affinity
infixr 4 =.
infixr 4 <.
infixr 4 >.
infixr 4 ≤
infixr 4 ≥

-- Testing ---------------------------------------------------------------------------------------------------------------------------------

-- |
main :: IO ()
main = do
  putStrLn "Let's see if it works"
  print $ (fold (++) "Hello" " " "World" :: String)
  print $ ((0 :: Int) <. ((5 :: Int) <. (10 :: Int) :: (Int, Bool)) :: Bool)
