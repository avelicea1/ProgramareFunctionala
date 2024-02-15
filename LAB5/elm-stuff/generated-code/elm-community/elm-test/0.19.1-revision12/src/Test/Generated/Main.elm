module Test.Generated.Main exposing (main)

import DateTests
import Example
import ExerciseTests
import FirstTest
import OrganizedTests

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    Test.Runner.Node.run
        { runs = 100
        , report = ConsoleReport UseColor
        , seed = 56930050773992
        , processes = 8
        , globs =
            []
        , paths =
            [ "D:\\PF\\LAB5\\tests\\DateTests.elm"
            , "D:\\PF\\LAB5\\tests\\Example.elm"
            , "D:\\PF\\LAB5\\tests\\ExerciseTests.elm"
            , "D:\\PF\\LAB5\\tests\\FirstTest.elm"
            , "D:\\PF\\LAB5\\tests\\OrganizedTests.elm"
            ]
        }
        [ ( "DateTests"
          , [ Test.Runner.Node.check DateTests.suite
            ]
          )
        , ( "Example"
          , [ Test.Runner.Node.check Example.suite
            ]
          )
        , ( "ExerciseTests"
          , [ Test.Runner.Node.check ExerciseTests.suite
            ]
          )
        , ( "FirstTest"
          , [ Test.Runner.Node.check FirstTest.emptyListTakeTest
            ]
          )
        , ( "OrganizedTests"
          , [ Test.Runner.Node.check OrganizedTests.listTests
            ]
          )
        ]