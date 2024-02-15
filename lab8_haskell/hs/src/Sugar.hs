module Sugar where

-- >??
infixl 3 ??

(Just x) ?? _ = x
_ ?? def = def
-- <??

infixl 0 |>
x |> f = f x

infixr 0 <|
f <| x = f x

infixl 9 >>
f >> g = \x -> g (f x)

infixr 9 <<
f << g = \x -> f (g x)
