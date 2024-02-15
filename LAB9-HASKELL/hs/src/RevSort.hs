module RevSort where

import Data.List as L

newtype Rev a = Rev a deriving (Show, Eq)

--ex 9.9.5
instance (Ord a) => Ord (Rev a) where
    compare (Rev x) (Rev y) = compare y x

sortRev :: (Ord a) => [a] -> [a]
sortRev = L.sortOn Rev

-- f :: [Int] -> Int
-- f[1, 2] = 1
-- f[3, 4] = 3
-- f[_, _] = 2
-- f :: [String] -> Int 
-- f["a", "b"] = 1 
-- f("a":_) = 3 
-- f["a",_] = 2 
-- f["a", "b", "c"] = 4 
-- f _ = 5


merge3 x y z = merge (merge x y) z where
merge (u:us) (v:vs) 
  | u < v = u:merge us (v:vs)
  | u > v = v:merge (u:us) vs 
  | otherwise = u:merge us vs
 
ham ::[Integer]
ham = 1:merge3 ham2 ham3 ham5
ham2 = [ 2*i | i <- ham ]
ham3 = [ 3*i | i <- ham ]
ham5 = [ 5*i | i <- ham ]

hammingGen :: Int -> [Integer] 
hammingGen n = take n ham 


mul3 a b c = a*b*c
m3 a b c = mul3 `fmap` a <*>b<*>c

f g v [] = []
f g v (x:xs) = v:f g (g v x) xs

newtype Any = Any Bool
instance Semigroup Any where
   (Any a) <> (Any b) = Any (a || b)
instance Monoid Any where
   mempty = Any False

