module MakeTuple exposing (..)
import Shape exposing (TriangleSide(..))

makeTuple : a -> b -> (a, b)
makeTuple a b = (a, b)

makeTuple : fst -> snd -> (fst, snd)
makeTuple a b = (a, b)

makeTuple : b -> a -> (b, a)
makeTuple a b = (a, b)

makeTuple : x -> y -> (x, y)
makeTuple elem1 elem2 = (elem1, elem2)


