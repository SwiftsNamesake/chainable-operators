--
-- Experimenting with chained comparisons, as seen
-- in Python and mathematical notation
--

-- TODO | - Create library, publish
--        - Unicode operators
--        - Come up with a good name
--        - How to deal with open-world assumption



{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE ScopedTypeVariables    #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE InstanceSigs #-}

-- |
class ComparableOutcome b where
  -- TODO | - This function is important, and needs further consideration
  --        - Pass along the value to the right to the next step in the chain
  --        - 'Collect' the results
  --        - Allow l.h.s and r.h.s to be of different types (?)
  chain :: Bool -> (Int -> Int -> Bool) -> Int -> Int -> b


-- |
instance ComparableOutcome ((Int -> Int -> Bool) -> Int -> Bool) where
  chain p f a b = \g c -> p && (f a b) && (g b (c :: Int))


-- |
-- instance ComparableOutcome a b => ComparableOutcome b a where
--   chain p f a b = undefined


instance ComparableOutcome Bool where
  chain p f a b = p && f a b


-- |
chainable :: (a -> a -> Bool) -> _
chainable f = _


-- | Chainable operators
-- (==.) :: (Eq a, ComparableOutcome a b) => a -> a -> b
-- (==.) = chainable (==)

-- (<.) :: (Ord a, ComparableOutcome b) => a -> a -> b
(<.) = chainable (<)

-- (>.) :: (Ord a, ComparableOutcome a b) => a -> a -> b
-- (>.) = chainable (>)

-- (≤) :: (Ord a, ComparableOutcome a b) => a -> a -> b
-- (≤) = chainable (<=)

-- (≥) :: (Ord a, ComparableOutcome a b) => a -> a -> b
-- (≥) = chainable (>=)


-- TODO | - Decide affinity
-- infixr 4 ==.
infixr 4 <.
-- infixr 4 >.
-- infixr 4 ≤
-- infixr 4 ≥


-- |
main :: IO ()
main = do
  putStrLn $ "5 is greater than 2 and less than 16"
  print $ ((((0 :: Int) <. (2 :: Int) :: (Int -> Int -> Bool) -> Int -> Bool) (<) (5 :: Int)) :: Bool)

  -- putStrLn $ "0.72 is between 0 and 1"
  -- print $ 0.00 ≤ 0.72 ≤ 1.00