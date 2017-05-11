-- |
-- Module      : Chainable
-- Description : Operators are meant to be chained
-- Copyright   : (c) Jonatan Sundqvist, 2017
-- License     : MIT
-- Maintainer  : Jonatan H Sundqvist
-- Stability   : experimental
-- Portability : portable
--

-- TODO | - Shadow Prelude's (>) and (<) (?)
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


-- |
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
  -- x₀ = 2.6
  -- x₁ = n
  putStrLn "Let's see if it works"
  putStrLn $ fold (++) "Hello" " " "World"
  print $ ((0 :: Int) <. ((5 :: Int) <. (10 :: Int) :: (Int, Bool)) :: Bool)
