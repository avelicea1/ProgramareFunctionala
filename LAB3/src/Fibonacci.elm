module Fibonacci exposing (..)

fibs : Int -> Int -> List Int
fibs start end =
    let
        generateFib a b idx =
            if idx <= start then
                generateFib b (a + b) (idx + 1)
            else if idx <= end then
                a :: generateFib b (a + b) (idx + 1)
            else
                []
    in
    if start < 0 then
        [1]
    else
        generateFib 1 1 1

fib n = if (n == 0) || (n == 1) then 1 else (fib(n - 1)) + (fib(n - 2))