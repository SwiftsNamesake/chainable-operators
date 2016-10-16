--
-- Experimenting with varargs
--


{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}

-- class FoldRes a where {}

class VarFold a b c where
  fold :: (b -> a -> b) -> b -> a -> c


instance VarFold a b c => VarFold a b b where
  fold f acc a = f acc a


main :: IO ()
main = do
  putStrLn "Let's see if it works"
