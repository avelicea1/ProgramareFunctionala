module Records exposing (..)
type alias User =
    { firstName : String, lastName : String }
type Person = Person String String Int
greet: Person -> String
greet ( Person firstName _ _) = "Hello, " ++ firstName

type alias PersonRec = {firstName : String, lastName: String, age: Int}