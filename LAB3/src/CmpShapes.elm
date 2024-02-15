module CmpShapes exposing (..)

type Shape
  = Circle Float
  | Rectangle Float Float
  | Triangle Float Float Float

heron a b c =
  let
    s = (a + b + c) / 2
  in
    sqrt (s * (s - a) * (s - b) * (s - c))



safeArea : Shape -> Result String Float
safeArea shape =
  case shape of
    Circle radius ->
      if radius < 0 then
        Err "Negative circle radius"
      else
        Ok (pi * radius * radius)
    Rectangle width height ->
      if (width < 0) || (height < 0) then
        Err "Negative rectangle width or height"
      else
        Ok (width * height)
    Triangle a b c ->
      case safeHeron a b c of
        Just area -> Ok area
        Nothing -> Err "Sides can't form a triangle"



validTriangle a b c =
  ((a > 0) && (b > 0) && (c > 0)) &&
  ((a + b >= c) && (a + c >= b) && (b + c >= a))



safeHeron : Float -> Float -> Float -> Maybe Float
safeHeron a b c =
  if not (validTriangle a b c) then
    Nothing
  else
    Just (heron a b c)


cmpShapes : Shape -> Shape -> Result String Order
cmpShapes shape1 shape2 =
    case (safeArea shape1, safeArea shape2) of
        (Ok area1, Ok area2) ->
            if area1 < area2 then
                Ok LT
            else if area1 > area2 then
                Ok GT
            else
                Ok EQ
        (Err errMsg1, Ok _) ->
            Err ("Invalid input for left shape: " ++ errMsg1)

        (Ok _, Err errMsg2) ->
            Err ("Invalid input for right shape: " ++ errMsg2)

        (Err errMsg1, Err errMsg2) ->
            Err ("Invalid input for both shapes: " ++ errMsg1 ++ " and " ++ errMsg2)
