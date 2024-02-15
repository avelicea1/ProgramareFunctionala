module PointInShape exposing (..)
type alias Point = {x: Float, y: Float}
type Shape2D = 
    Circle {center: Point, radius: Float}
    | Rectangle {topLeftCorner: Point, bottomRightCorner: Point}
    | Triangle {pointA: Point, pointB: Point, pointC: Point}
--distanta dintre 2 puncte
distance : Point -> Point -> Float
distance p1 p2 =
    let
        dx = p1.x - p2.x
        dy = p1.y - p2.y
    in
    sqrt (dx * dx + dy * dy)
    
--aria triunghiului
areaOfTriangle : Point -> Point -> Point -> Float
areaOfTriangle a b c =
    let
        ab = distance a b
        ac = distance a c
        bc = distance b c
        s = (ab + ac + bc) / 2
    in
    sqrt (s * (s - ab) * (s - ac) * (s - bc))


pointInShape : Point -> Shape2D -> Bool
pointInShape point shape =
    case shape of
        Circle { center, radius } ->
            let
                d = distance point center
            in
            d < radius

        Rectangle { topLeftCorner, bottomRightCorner } ->
            point.x > topLeftCorner.x
                && point.x < bottomRightCorner.x
                && point.y < topLeftCorner.y
                && point.y > bottomRightCorner.y

        Triangle { pointA, pointB, pointC } ->
            let
                areaABC = areaOfTriangle pointA pointB pointC
                areaPAB = areaOfTriangle point pointA pointB
                areaPAC = areaOfTriangle point pointA pointC
                areaPBC = areaOfTriangle point pointB pointC
            in
            abs (areaABC - (areaPAB + areaPAC + areaPBC)) < 0.0001