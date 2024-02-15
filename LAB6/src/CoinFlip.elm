module CoinFlip exposing (..)

import Browser
import Html exposing (Html, button, div, text, p)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Random

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

type CoinSide
  = Heads
  | Tails

type alias Model =
  { currentFlips : List CoinSide
  , flips : List CoinSide
  }

initModel = Model [] []

init : () -> (Model, Cmd Msg)
init _ =
  (initModel, Cmd.none)

type Msg
  = Flip Int
  | AddFlip CoinSide

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Flip n ->
      let
        flipCmds = List.repeat n (Random.generate AddFlip coinFlip)
      in
      (model, Cmd.batch flipCmds)

    AddFlip coin ->
      let
        newModel =
          { model | currentFlips = coin :: model.currentFlips, flips = coin :: model.flips }
      in
      (newModel, Cmd.none)

coinFlip : Random.Generator CoinSide
coinFlip =
  Random.uniform Heads [Tails]

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

view : Model -> Html Msg
view model =
  let
    currentFlips =
      model.currentFlips
        |> List.reverse
        |> List.map viewCoin
    flips =
      model.flips
        |> List.map coinToString
        |> List.intersperse " "
        |> List.map text
    headCount =
      model.flips
        |> List.filter (\coin -> coin == Heads)
        |> List.length
    tailCount =
      model.flips
        |> List.filter (\coin -> coin == Tails)
        |> List.length
  in
  div []
    [ button [ onClick (Flip 10) ] [ text "Flip 10" ]
    , button [ onClick (Flip 100) ] [ text "Flip 100" ]
    , div [] currentFlips
    , div [] flips
    , div [] [ text ("Heads: " ++ String.fromInt headCount) ]
    , div [] [ text ("Tails: " ++ String.fromInt tailCount) ]
    ]

coinToString : CoinSide -> String
coinToString coin =
  case coin of
    Heads -> "h"
    Tails -> "t"

viewCoin : CoinSide -> Html Msg
viewCoin coin =
  let
    name = coinToString coin
  in
  div [ style "font-size" "4em" ] [ text name ]
