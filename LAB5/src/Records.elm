module Records exposing (..)
import Shape exposing (TriangleSide(..))


type Color = Red | Green | Blue



type alias ColoredCircle = { x: Int, y: Int, color: Color, radius: Int}



moveConstructor : ColoredCircle -> Int -> Int -> ColoredCircle
moveConstructor circle dx dy =
  ColoredCircle (circle.x + dx) (circle.y + dy) circle.color circle.radius



moveRec : ColoredCircle -> Int -> Int -> ColoredCircle
moveRec circle dx dy =
  { x = circle.x + dx
  , y = circle.y + dy
  , color = circle.color
  , radius = circle.radius
  }



moveDestructure : ColoredCircle -> Int -> Int -> ColoredCircle
moveDestructure circle dx dy =
  let 
    { x, y, color, radius } = circle
  in
    { x = x + dx, y = y + dy, color = color, radius = radius }



moveUpdate : ColoredCircle -> Int -> Int -> ColoredCircle
moveUpdate circle dx dy =
  { circle | x = circle.x + dx, y = circle.y + dy }

type alias Point =  { x: Int, y: Int, z: Int}

-- ex 5 4 1
type alias ColoredSphere = {center: Point, color: Color, radius: Int}

moveUpdate1 : ColoredSphere -> Int -> Int -> ColoredSphere
moveUpdate1 s dx dy =
  let
    updateCenter p deltaX deltaY = 
      { p | x = p.x + deltaX, y = p.y + deltaY, z = p.z}
  in
    {s | center = updateCenter s.center dx dy}


-- ex 5_5_1
map2 : (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
map2 func maybeA maybeB =
  case (maybeA, maybeB) of
    (Just a, Just b) -> Just (func a b)
    _->Nothing

-- ex 5_8_1

isVowel : Char -> Bool
isVowel char =
    let
        lowerChar = Char.toLower char
    in
    lowerChar == 'a' || lowerChar == 'e' || lowerChar == 'i' || lowerChar == 'o' || lowerChar == 'u'

-- Define a function to count vowels in a given string
countVowels : String -> Int
countVowels text =
    text
        |> String.toLower
        |> String.filter (\char -> isVowel char)
        |> String.length

