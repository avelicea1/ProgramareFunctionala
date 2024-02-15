module Exercitii where

-- import Control.Applicative (liftA3)

-- import qualified Data.Set as Set


-- --ex 10.8.1
-- data Tree a = Nil | Node (Tree a) a (Tree a) deriving (Show)

-- instance Functor Tree where
--   fmap _ Nil = Nil
--   fmap f (Node left x right) = Node (fmap f left) (f x) (fmap f right)
  

-- --ex 10.8.2

-- passwords :: Int -> [String]
-- passwords n = take (62^n) $ sequenceA $ replicate n (['0'..'9'] ++ ['a'..'z'] ++ ['A'..'Z'])

-- f g v [] = []
-- f g v (x:xs) = v:f g (g v x) xs 

-- merge [] [] = []
-- merge xs [] = xs
-- merge [] ys = ys
-- merge (x:xs) (y:ys)
--   | x < y = x:merge xs (y:ys)
--   | x == y = x:merge xs ys
--   | otherwise = y:merge (x:xs) ys 

-- l1 = [x * 2 | x <- [1..]] :: [Int]
-- l2 = [x * 3 | x <- [1..]] :: [Int] 


-- merge3 x y z = merge (merge  x y) z where
--   merge (u:us) (v:vs)
--     | u < v = u:merge us (v:vs)
--     | u > v = v:merge (u:us) vs
--     | otherwise = u:merge us vs

-- ham :: [Integer]
-- ham = 1:merge3 ham2 ham3 ham5

-- ham2 = [ 2*i | i <- ham]

-- ham3 = [ 3*i | i <- ham]

-- ham5 = [ 5*i | i <- ham]

-- hammingGen ::Int -> [Integer]
-- hammingGen n = take n ham

-- type Person = (String, Int, Char, String)

-- a1 :: Person
-- a1 = ("Brad", 59, 'M', "L. A.");

-- (thename, theage, thegender, theaddress) = a1

-- -- infixr 8 |^| 
-- -- x |^| y = "(" ++ x ++ "^" ++ y ++ ")"

-- -- data Matrix2x2 = Mat2 ((Integer, Integer),(Integer, Integer))
-- --   deriving (Show)


-- -- instance Num Matrix2x2 where
-- -- Mat2 (al1, al2) * Mat2 (bl1, bl2) =
-- --   let
-- --     (a11, a12) = al1 -- deconstructing lines
-- --     (a21, a22) = al2
-- --     (b11, b12) = bl1
-- --     (b21, b22) = bl2
-- --   in
-- --     Mat2 ((a11*b11+a12*b21, a11*b12+a12*b22),
-- --     (a21*b11+a22*b21, a21*b12+a22*b22))

-- -- infixr 8 |^|
-- -- Mat2 (al1, al2) |^| n =
-- --   if (n==0) then Mat2 ((1,0), (0,1))
-- --   else Mat2 (al1, al2) * Mat2 (al1, al2) |^| (n-1)

-- squares n = map (\ x -> x*x) [n, n+1, n+2]

-- -- qs :: Ord a => [a] -> [a]
-- -- qs [] = []
-- -- qs (x:xs) = qs smalls ++ [x] ++ qs bigs
-- --   where
-- --     smalls = [s | s<-xs, s<=x]
-- --     bigs = [b | b<-xs, b>x]

-- my_split _ [] smalls bigs = (smalls,bigs)
-- my_split x (y:ys) smalls bigs
--   | y < x = my_split x ys (y:smalls) bigs
--   | otherwise = my_split x ys smalls (y:bigs)
-- qs [] = []
-- qs (x:xs) = qs smalls ++ [x] ++ qs bigs
--   where
--     (smalls,bigs) = my_split x xs [] []

-- elim :: Eq a => a -> [a] -> [a]
-- elim _ [] = []
-- elim e (x:xs) | e == x = elim e xs
--   | otherwise = x:elim e xs

-- pr :: Eq t => [t] -> [[t]]
-- pr [] = [[]]
-- pr xs = [ a:p | a <- xs , p <- pr (elim a xs)]

-- crossEnt :: Floating t => [t] -> [t] -> t
-- crossEnt ts ps =
--   if (null ts) then 0
--   else ((-1) * (head ts) * (logBase 2 (head ps))
--   + crossEnt (tail ts) (tail ps))

-- -- adElem :: Ord t => t -> Set.Set t -> Set.Set t
-- -- adElem e [] = [e]
-- -- adElem e (a:xs) | e < a = e:a:xs
-- --                 | e == a = a:xs
-- --                 | otherwise = a:adElem e (xs)

-- -- listToSet :: Ord t => [t] -> Set.Set t
-- -- listToSet [] = []
-- -- listToSet (x:xs) = adElem x (listToSet xs)

-- -- delElem :: Ord t => t -> Set.Set t -> Set.Set t
-- -- delElem e [] = []
-- -- delElem e (a:x) | e < a = a:x
-- --   | e == a = x
-- --   | otherwise = a:delElem e x

-- -- subset :: Ord a => Set.Set a -> Set.Set a -> Bool
-- -- subset [] _ = True
-- -- subset _ [] = False
-- -- subset (a:s) (b:t)
-- --   | a == b = subset s t
-- --   | a < b = False
-- --   | otherwise = subset (a:s) t

-- -- ors s = foldr (++) [] (map perm (powerset s))

-- unfold p h t x 
--   | p x = []
--   | otherwise = (h x ) : unfold p h t (t x)

-- myspan p xs = (takeWhile p xs, dropWhile p xs)

-- mysplitAt n xs = (take n xs, drop n xs)

-- -- 2 4 8 6 10 
-- -- 3 6 9 15 18
-- -- 5 10 15 25

-- -- 1 2 3 4 5 6 8 9 10 12 15 16 18 20  


-- alist = 1 : 4*el : el : 2*el : 3*el : alist where 
--   el = head (tail (tail (tail (tail (tail alist)))))
-- romana e | e == 1 = "unu"
--          | e == 2 = "doi"
--          | e == 3 = "trei"
--          | otherwise = "patru s-un"

-- li = 1 : 4*el : 2*el : 5*el : 3*el : li where
--   el = head (tail (tail (tail (tail (tail li)))))
-- foo = take 9 (map espagnol (tail li)) where
--   espagnol e | e == 1 = "uno"
--     | e == 2 = "dos"
--     | e == 3 = "tres"
--     | otherwise = "chacha"

-- s1 = i (\n -> 2*n) 2 where i f x = x : i f (f x)


-- unfold p h t x
--   | p x = []
--   | otherwise = (h x) : unfold p h t (t x)

-- seria A 2023
-- s1 = i (\n -> n * 2) 2
-- where
-- i f x = x : i f (f x)

-- 2022
-- s1 = [2 ^ n | n <- [0, 2 ..]]

-- f g h i j
--   | g j = []
--   | otherwise = (h j) : f g h i (i j)

-- s2 = f g h i [0..]
--   where
--     g = \ns -> ns == []
--     h = \ns -> s1 !! (head ns)
--     i = \ns -> tail ns

-- s1 = [ 2^(2*n) | n <- [0,4..]]
-- a b c d z | c z == False = []
--           | otherwise = (b z) : a b c d (d(d z))
-- s2 = a b c d [0..] where
--   b ns = (^) 2 ((*) 4 (head ns))
--   c ns = (/= []) ns 
--   d ns = tail ns

-- f1 n = s !! n where
--     s = 0:1:zipWith (+) s (tail s)
-- f2 n = (u p h t (0,1)) !! n where
--     u p h t x 
--       | p x = []
--       | otherwise = (h x) : u p h t (t x)
-- p = (\(a, b) -> False)  -- p checks if the first element of the tuple is 3
-- h = (\(a, b) -> a)        -- h returns the first element of the tuple
-- t = (\(a, b) -> (b, a + b)) -- t generates the next tuple in the Fibonacci sequence


u :: (a-> Bool) -> (a -> b) -> (a -> a) -> a -> [b]

u p h t x | p x = []
          | otherwise = h x : u p h t ( t x)

j :: (a->a) -> a -> [a]
j f x = x : j f f(x)

p x = False
h x = xs
t x = f x
