module Test exposing (..)
import List exposing (map)
type alias Triangle = {a:Int, b:Int, c: Int}

triangles = [ (Triangle 2 3 4), (Triangle 3 4 5), (Triangle 6 6 4)]

changeA : List Triangle -> List Triangle
changeA triangleList = triangleList |> map (\triangle -> {triangle | a = triangle.a + 2})

changeB : List Triangle -> List Triangle
changeB triangleList = triangleList |> map (\triangle -> {triangle | b = triangle.b + 1})

changeC : List Triangle -> List Triangle
changeC triangleList = triangleList |> map (\triangle -> {triangle | c = triangle.c + 3})

