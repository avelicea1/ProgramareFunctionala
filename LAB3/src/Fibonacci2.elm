module Fibonacci2 exposing (..)

fibs2 : Int -> Int -> List (Int, Int)
fibs2 start end =
    let
        generateFib a b idx =
            if idx <= start then
                generateFib b (a + b) (idx + 1)
            else if idx <= end then
                (idx - 1, a) :: generateFib b (a + b) (idx + 1)
            else
                []
    in
    if start < 0 then
        [(0, 1)]
    else
        generateFib 1 1 1