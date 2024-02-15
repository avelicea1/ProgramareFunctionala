module Lists exposing (..)
import Html exposing (a)

countFromTo : Int -> Int -> List Int
countFromTo from to =
  if from >= to then
    []
  else
    from :: countFromTo (from + 1) to

len : List Int -> Int
len l = 
  case l of 
    [] -> 0
    _::xs -> 1 + len xs

lenTail : List Int -> Int
lenTail list = 
  let
    lenAcc: List Int -> Int -> Int
    lenAcc l acc = 
      case l of
          [] -> acc
          _::xs -> lenAcc xs (acc + 1)
  in
  lenAcc list 0
  
sumOfElements : List Int -> Int
sumOfElements l =
  case l of
    [] -> 0
    x::xs -> x + sumOfElements xs



countFromToTail : Int -> Int -> List Int
countFromToTail from to =
  let
    cnt a b acc = 
      if a >= b then
        acc
      else
        cnt a (b - 1) ((b - 1)::acc)
  in
    cnt from to []



append : List a -> List a -> List a
append lx ly =
  case lx of
    [] -> ly
    x::xs -> x :: append xs ly



reverse : List a -> List a
reverse l =
  let
    reverseAcc lx acc = 
      case lx of
        [] -> acc
        x::xs -> reverseAcc xs (x::acc)
  in
    reverseAcc l []



appendTail : List a -> List a -> List a
appendTail la lb =
  let
    appTail lx acc =
      case lx of 
        [] -> acc
        x::xs -> appTail xs (x::acc)
  in
    appTail (reverse la) lb



head : List a -> Maybe a
head l =
  case l of
    [] -> Nothing
    x::_ -> Just x


last : List a -> Maybe a
last l = 
  case List.reverse l of 
    [] -> Nothing
    x:: _ -> Just x

tail : List a -> Maybe (List a)
tail l =
  case l of
    [] -> Nothing
    _::xs -> Just xs

indexList: Int -> List a -> Maybe a
indexList i list = 
  case (i, list) of
      (0, x :: _) -> Just x
      (_,_ :: rest) -> indexList (i - 1) rest
      _-> Nothing


