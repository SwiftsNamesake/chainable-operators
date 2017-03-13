--
-- Experimenting with chained comparisons, as seen
-- in Python and mathematical notation
--

-- TODO | - Create library, publish
--        - Unicode operators
--        - Come up with a good name
--        - How to deal with open-world assumption


import qualified Chainable as Chainable


-- |
main :: IO ()
main = do
  Chainable.main
--   putStrLn $ "5 is greater than 2 and less than 16"
--   print $ ((((0 :: Int) <. (2 :: Int) :: (Int -> Int -> Bool) -> Int -> Bool) (<) (5 :: Int)) :: Bool)

  -- putStrLn $ "0.72 is between 0 and 1"
  -- print $ 0.00 ≤ 0.72 ≤ 1.00
