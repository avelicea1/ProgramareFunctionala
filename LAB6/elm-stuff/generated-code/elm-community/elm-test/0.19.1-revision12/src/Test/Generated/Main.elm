module Test.Generated.Main exposing (main)

import CoinFlipTests
import CounterTests
import RecipeTests

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    Test.Runner.Node.run
        { runs = 100
        , report = ConsoleReport UseColor
        , seed = 273023750081412
        , processes = 8
        , globs =
            []
        , paths =
            [ "D:\\PF\\LAB6\\tests\\CoinFlipTests.elm"
            , "D:\\PF\\LAB6\\tests\\CounterTests.elm"
            , "D:\\PF\\LAB6\\tests\\RecipeTests.elm"
            ]
        }
        [ ( "CoinFlipTests"
          , [ Test.Runner.Node.check CoinFlipTests.initialViewTest
            ]
          )
        , ( "CounterTests"
          , [ Test.Runner.Node.check CounterTests.viewHasTwoButtons
            , Test.Runner.Node.check CounterTests.viewContainsTheCurrentCount
            , Test.Runner.Node.check CounterTests.buttonDisabledOver10
            ]
          )
        , ( "RecipeTests"
          , [ Test.Runner.Node.check RecipeTests.atLeastOneIngredient
            , Test.Runner.Node.check RecipeTests.atLeastOneIngredientClass
            , Test.Runner.Node.check RecipeTests.eachIngredientHasClassIngredient
            ]
          )
        ]