-- |
-- Module      : Chainable
-- Description : Operators are meant to be chained
-- Copyright   : (c) Jonatan Sundqvist, 2017
-- License     : MIT
-- Maintainer  : Jonatan H Sundqvist
-- Stability   : experimental
-- Portability : portable
--

-- TODO | - Shadow Prelude's, (==), (>) and (<) (?)
--        -

-- SPEC | -
--        -

-- GHC Pragmas -----------------------------------------------------------------------------------------------------------------------------

{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE TypeFamilies           #-}
{-# LANGUAGE EmptyDataDecls         #-}
-- {-# LANGUAGE OverlappingInstances #-}

-- API -------------------------------------------------------------------------------------------------------------------------------------

module Chainable where

-- Definitions -------------------------------------------------------------------------------------------------------------------------------------

-- TODO | - Short-circuiting
--        - Extensible (ie. allow different types of chaining)
--        - Type-inferrable (no intermediary annotations)

-- |
data Lock
data Ok

-- |
-- type family Chainable where
--   chainable f (carried, previous) a = _
--   chainable f a                   b = -- (a, f a b)
class ChainableFamily a where
  type Link a p r


instance ChainableFamily Lock where
  type Link Lock Double         Bool           = Ok
  type Link Lock Double         (Double, Bool) = Ok
  type Link Lock (Double, Bool) (Double, Bool) = Ok
  type Link Lock (Double, Bool) Bool           = Ok


-- TODO | - This class should be as flexible as possible
class Link Lock p r ~ Ok => Chainable p r where
  chainable :: (Double -> Double -> Bool) -> p -> Double -> r


instance Chainable Double (Double, Bool) where
  chainable f a b = (b, f a b)


instance Chainable Double Bool where
  chainable f a b = f a b


instance Chainable (Double, Bool) (Double, Bool) where
  chainable f (carried, previous) b = (b, (f carried b) && previous)


instance Chainable (Double, Bool) Bool where
  chainable f (carried, previous) b = (f carried b) && previous

-- (a -> a -> Bool) -> a         -> a -> Bool      --
-- (a -> a -> Bool) -> a         -> a -> (a, Bool) --
-- (a -> a -> Bool) -> (a, Bool) -> a -> (a, Bool) --
-- (a -> a -> Bool) -> (a, Bool) -> a -> Bool      --

-- Chainable operators ---------------------------------------------------------------------------------------------------------------------

-- | Chainable equality
(=.) :: (Chainable p r) => p -> Double -> r
(=.) = chainable (==)


-- | Chainable less-than
-- (<.) :: (Chainable p r) => p -> Double -> r
-- (<.) = chainable (<)
(<.) :: Ord a => a -> a -> (a, Bool)
(<.) = chainBegin (<)

(<:) :: Ord a => (a, Bool) -> a -> Bool
(<:) = chainEnd (<)


-- | Chainable greater-than
(>.) :: (Chainable p r) => p -> Double -> r
(>.) = chainable (>)


-- | Chainable less-or-equal
(≤) :: (Chainable p r) => p -> Double -> r
(≤) = chainable (<=)


-- | Chainable greater-or-equal
(≥) :: (Chainable p r) => p -> Double -> r
(≥) = chainable (>=)


-- |
-- TODO | - Decide affinity
infixl 4 =.
infixl 4 <.
infixl 4 <:
infixl 4 >.
infixl 4 ≤
infixl 4 ≥


-------

chainBegin :: (a -> a -> Bool) -> a -> a -> (a, Bool)
chainBegin f a b = (b, f a b)

chainEnd :: (a -> a -> Bool) -> (a, Bool) -> a -> Bool
chainEnd f (a, p) b = f a b && p

-- Testing ---------------------------------------------------------------------------------------------------------------------------------

-- |
main :: IO ()
main = do
  putStrLn "Let's see if it works"

  putStrLn "A slightly less complicated solution, based on different operators."

  putStrLn "A more complicated solution, based on overloading"
  print $ 0 <. 1 <: 2
  -- x₀ = 2.6
  -- x₁ = n
  -- putStrLn $ fold (++) "Hello" " " "World"
  -- print comparison --(((0.0 :: Double) <. (0.3 :: Double)) <. (1.0 :: Double) :: Bool)
  -- where
  --   comparison :: Bool
  --   comparison = ((0.0 :: Double) <. 0.2 :: (Double, Bool)) <. 1.0
