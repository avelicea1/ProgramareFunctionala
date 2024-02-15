module Circular where

import Prelude 

twos :: [Integer]
twos = 2:twos

rep :: t -> [t]
rep e = e:(rep e)

fibs :: [Integer]
fibs = 0:1:(zipWith (+) fibs (tail fibs))

count :: [Integer]
count = 1:(map (+1) count)

powsOf2 :: [Integer]
powsOf2 = 2:(map (*2) powsOf2)

oneList :: [[Integer]]
oneList = [1]:(map (1:) oneList)

primes :: [Integer]
primes = sieve [2..] where 
  sieve (x:xs) = x:sieve [ y | y <- xs, mod y x /= 0]


cycl :: [a] -> [a]
cycl xs = cycle xs

series :: [[Int]]
series = map (\n -> [n, n-1..1]) [1..]

iter :: (a -> a) -> a -> [a]
iter f x = iterate f x

squareSums :: (Num a, Eq a, Enum a) => a -> [(a, a, a)]
squareSums n = [(a, b, c) | c <- [1..n], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2]

nextSqrt :: Fractional a => a -> a -> a
nextSqrt x y = (x/y + y) / 2

approxS :: Fractional a => a -> [a]
approxS x = iterate (nextSqrt x) 1

goodEnough :: (Ord a, Num a) => a -> (a, a) -> Bool
goodEnough eps (x, y) = abs (x - y) < eps

genApprox :: (Ord a, Fractional a) => a -> a -> a -> Int -> [a]
genApprox eps x start maxIterations = takeWhile (\y -> not $ goodEnough eps (x, y)) $ take maxIterations $ approxS x

approxSqrt :: (Ord a, Fractional a) => a -> a -> Int -> a
approxSqrt eps x maxIterations = last $ genApprox eps x 1 maxIterations