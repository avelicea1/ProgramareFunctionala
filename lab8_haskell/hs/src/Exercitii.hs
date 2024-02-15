module Exercitii where

import Data.List (unfoldr)

--8.12.1
sudan :: Integer -> Integer -> Integer -> Integer
sudan n x y
  | n == 0           = x + y
  | n > 0 && y == 0  = x
  | otherwise        = s (n - 1) (s n x (y - 1)) (y + s n x (y - 1))
  where
    s n' x' y' = sudan n' x' y'

--8.12.2
infix 3 !&

(!&) :: Bool -> Bool -> Bool
x !& y = not (x && y)


--8.12.3
safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

safeTail :: [a] -> Maybe [a]
safeTail []     = Nothing
safeTail (_:xs) = Just xs

--8.12.4
average :: [Int] -> Float
average [] = 0.0

average xs = fromIntegral (sum xs) / fromIntegral (length xs)

--8.12.5
countVowels :: String -> Int
countVowels str = length [c | c <- str, c `elem` "aeiouAEIOU"]

--8.12.6

addBigs :: [Int] -> [Int] -> [Int]
addBigs xs ys = reverse $ addBigs' (reverse xs) (reverse ys) 0
  where
    addBigs' [] [] carry = if carry == 0 then [] else [carry]
    addBigs' [] ys carry = addBigs' [0] ys carry
    addBigs' xs [] carry = addBigs' xs [0] carry
    addBigs' (x:xs) (y:ys) carry =
      let sumResult = x + y + carry
          (newCarry, digit) = divMod sumResult 10
      in digit : addBigs' xs ys newCarry

--8.12.7

fact :: Integer -> Integer
fact n = product [1..n]

breakToLines :: Int -> String -> [String]
breakToLines lineLen str = unfoldr breakHelper str
  where
    breakHelper :: String -> Maybe (String, String)
    breakHelper s
      | null s = Nothing
      | otherwise = Just (splitAt lineLen s)

formatLines :: [String] -> String
formatLines = unlines