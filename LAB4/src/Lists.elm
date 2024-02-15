module Lists exposing (..)

import Functions exposing (..)
import Html exposing (a)
import Html exposing (u)


take : Int -> List a -> List a
take n l =
  if n <= 0 then
    []
  else
    case l of
      [] -> []
      x::xs -> x :: take (n - 1) xs



drop : Int -> List a -> List a
drop n l =
  if n <= 0 then
    l
  else
    case l of
      [] -> []
      _::xs -> drop (n - 1) xs



checkTakeDrop : Int -> List a -> Bool
checkTakeDrop n l =
  let
    prefix = take n l
    suffix = drop n l
  in
    Debug.todo "Complete this with prefix and suffix and l such that it always returns true"



takeWhile : (a -> Bool) -> List a -> List a
takeWhile p l =
  case l of
    [] -> []
    x::xs -> 
      if p x then
        x :: takeWhile p xs
      else
        []



dropWhile : (a -> Bool) -> List a -> List a
dropWhile p l =
  case l of
    [] -> []
    x::xs -> 
      if p x then
        dropWhile p xs
      else
        x::xs



zip : List a -> List b -> List (a, b)
zip lx ly =
  case (lx, ly) of
    (x::xs, y::ys) -> (x, y)::(zip xs ys)
    _ -> []




unzip : List (a, b) -> (List a, List b)
unzip l =
  case l of
    [] -> ([], [])
    (x, y)::ls -> 
      let
        (xs, ys) = unzip ls
      in
        (x::xs, y::ys)



map : (a -> b) -> List a -> List b
map fn l =
  case l of 
    [] -> []
    x::xs -> (fn x)::map fn xs

  

filter : (a -> Bool) -> List a -> List a
filter pred l =
  case l of 
    [] -> []
    x::xs -> 
      if (pred x) then
        x::filter pred xs
      else
        filter pred xs



foldr : (a -> b -> b) -> b -> List a -> b
foldr op start l =
  case l of
    [] -> start
    x::xs -> op x (foldr op start xs)



foldl : (a -> b -> b) -> b -> List a -> b
foldl op start l =
  case l of
    [] -> start
    x::xs -> foldl op (op x start) xs




all : (a -> Bool) -> List a -> Bool
all pred l =
  case l of 
    [] -> True
    x::xs -> 
      if pred x then
        all pred xs
      else
        False



any : (a -> Bool) -> List a -> Bool
any pred l =
  case l of
    [] -> False
    x::xs -> 
      if pred x then
        True
      else
        any pred xs



partition : comparable -> List comparable -> (List comparable, List comparable)
partition pivot l = 
  (filter (\x -> x < pivot) l, filter (\x -> x >= pivot) l)



quicksort : List comparable -> List comparable
quicksort l =
  case l of
    [] -> []
    x::xs -> 
      let
        (less, greater) = partition x xs
      in
        (quicksort less) ++ [x] ++ (quicksort greater)


--ex 4.6.1
enumerate : List a -> List (Int, a)
enumerate l = 
  let
      enumerateHelper list index = 
        case list of 
          [] -> []
          x::xs -> (index, x):: enumerateHelper xs (index + 1)
  in
    enumerateHelper l 0

--ex 4.6.2
repeat : Int -> a -> List a
repeat n elem = 
  if n<=0 then 
    []
  else 
    elem :: repeat (n - 1) elem

countVowels : String -> Int
countVowels str =
    String.foldl
        (\char count ->
            if String.contains (String.fromChar char) "aeiou" then
                count + 1
            else
                count
        )
        0
        str


countriesWithCapital : List (String, String) -> (String -> Bool) -> List String
countriesWithCapital l pred = 
  case l of 
    [] -> []
    (x, y)::ls -> if (pred y) then x::(countriesWithCapital ls pred) 
                          else countriesWithCapital ls pred
  
partitionEx : comparable -> List comparable -> (List comparable, List comparable)
partitionEx pivot l =
    let
        partitionHelper1 : comparable -> List comparable -> List comparable
        partitionHelper1 p1 l1 =
            case l1 of
                [] -> []
                x :: xs ->
                    if x < p1 then
                        x :: partitionHelper1 p1 xs
                    else
                        partitionHelper1 p1 xs

        partitionHelper2 : comparable -> List comparable -> List comparable
        partitionHelper2 p2 l2 =
            case l2 of
                [] -> []
                x :: xs ->
                    if x >= p2 then
                        x :: partitionHelper2 p2 xs
                    else
                        partitionHelper2 p2 xs
    in
    (partitionHelper1 pivot l, partitionHelper2 pivot l)


filterMap : (a -> Maybe b) -> List a -> List b
filterMap pred l =
  case l of 
    [] -> []
    x::xs -> 
      case (pred x) of  
        Just value -> value::filterMap pred xs
        Nothing -> filterMap pred xs

-- oddLastDigit : Int -> Maybe Int
-- oddLastDigit x =
--     if modBy 2 x == 1 then
--         Just (modBy 10 x)
--     else
--         Nothing
-- chunks : Int -> List a -> List (List a)
-- chunks _ [] = []
-- chunks n list =
--     let
--         chunk = List.take n list
--         rest = List.drop n list
--     in
--     chunk :: chunks n rest

something lx ly = 
  case (lx, ly) of 
    ([], _) -> ly
    (_, []) -> lx
    (x::xs, y::ys) -> if x > y then x::something xs ly else y::something lx ys

mystery l =
  case l of
    [] -> []
    [x] -> [x]
    _ -> 
      let
        h = (List.length l) // 2
        a = (mystery (List.drop h l))
        b = (mystery (List.take h l))
      in
        something a b