module AdvancedLists exposing (..)

import Lists exposing (foldl, map, filter)


sumOfOddLastDigits : List Int -> Int
sumOfOddLastDigits l =
  foldl (+) 0 (map (modBy 10) (filter (\x -> modBy 2 x == 1) l))



sumOfOddLastDigitsPipe : List Int -> Int
sumOfOddLastDigitsPipe l =
  l 
    |> filter (\x -> modBy 2 x == 1)
    |> map (modBy 10)
    |> foldl (+) 0

all : (a -> Bool) -> List a -> Bool
all pred l = 
  l
    |> map pred
    |> foldl (&&) True

any : (a -> Bool) -> List a -> Bool
any pred l = 
  l
    |> map pred
    |> foldl (||) False

-- ex 5 2 1
-- applyTwice ( inc >> triple ) 1
-- (((1 + 1 ) * 3) + 1 ) * 3 = 21