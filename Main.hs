--
-- Experimenting with chained comparisons, as seen
-- in Python and mathematical notation
--

-- TODO | - Create library, publish
--        - Unicode operators
--        - Come up with a good name



{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE ScopedTypeVariables    #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE InstanceSigs #-}

-- |
class ComparableOutcome a b where
  -- TODO | - This function is important, and needs further consideration
  --        - Pass along the value to the right to the next step in the chain
  --        - 'Collect' the results
  --        - Allow l.h.s and r.h.s to be of different types (?)
  chain :: Bool -> (a -> a -> Bool) -> a -> a -> b


-- |
instance ComparableOutcome a ((a -> a -> Bool) -> a -> Bool) where
  chain :: Bool -> (a -> a -> Bool) -> a -> a -> b
  chain p f a b = \g c -> chain (p && f a b) g b c


-- |
-- instance ComparableOutcome a b => ComparableOutcome b a where
--   chain p f a b = undefined


instance ComparableOutcome a Bool where
  chain p f a b = p && f a b


-- | Chainable operators
(==.) :: (Eq a, ComparableOutcome a b) => a -> a -> b
(==.) = chain True (==)

(<.) :: (Ord a, ComparableOutcome a b) => a -> a -> b
(<.) = chain True (<)

(>.) :: (Ord a, ComparableOutcome a b) => a -> a -> b
(>.) = chain True (>)

(≤) :: (Ord a, ComparableOutcome a b) => a -> a -> b
(≤) = chain True (<=)

(≥) :: (Ord a, ComparableOutcome a b) => a -> a -> b
(≥) = chain True (>=)


-- TODO | - Decide affinity
infixr 4 ==.
infixr 4 <.
infixr 4 >.
infixr 4 ≤
infixr 4 ≥


-- |
main :: IO ()
main = do
  putStrLn $ "5 is greater than 2 and less than 16"
  print $ ((((0 :: Int) <. 2) <. (True)) :: Bool)

  -- putStrLn $ "0.72 is between 0 and 1"
  -- print $ 0.00 ≤ 0.72 ≤ 1.00