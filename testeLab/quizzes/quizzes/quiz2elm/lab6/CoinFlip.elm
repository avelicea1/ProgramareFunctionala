module CoinFlip exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
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
  { currentFlip : Maybe CoinSide
  , flips: List CoinSide,
    heads: Int,
    tails: Int
  }


initModel = Model Nothing [] 0 0


init : () -> (Model, Cmd Msg)
init _ =
  ( initModel
  , Cmd.none
  )



type Msg
  = Flip
  | AddFlip CoinSide



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Flip ->
      ( model
      , Random.generate AddFlip coinFlip
      )

    AddFlip coin ->
      ( Model (Just coin) (coin::model.flips) (if coin == Heads then model.heads+1 else model.heads) (if coin == Tails then model.tails+1 else model.tails)
      , Cmd.none
      )



coinFlip : Random.Generator CoinSide
coinFlip =
  Random.uniform Heads
    [ Tails ]



subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



view : Model -> Html Msg
view model =
  let
    currentFlip = 
      model.currentFlip 
      |> Maybe.map viewCoin
      |> Maybe.withDefault (text "Press the flip button to get started")
    flips = 
      model.flips 
      |> List.map coinToString
      |> List.intersperse " "
      |> List.map text
  in
    div []
      [ button [ onClick Flip ] [ text "Flip" ]
      , currentFlip,
      p [] [ text <|  "heads " ++ String.fromInt model.heads ],
      p [] [ text <| "tails " ++ String.fromInt model.tails ]
      , div [] flips
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

