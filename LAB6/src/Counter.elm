module Counter exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Html.Attributes exposing (disabled)

main =
  Browser.sandbox { init = 0, update = update, view = view }

type alias Model = Int

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      if model < 10 then 
        model + 1
      else
        model

    Decrement ->
      if model > -10 then 
        model - 1
      else 
        model

view : Model -> Html Msg
view model =
  let
    bigFont = style "font-size" "20pt"
    textColor = if model > 8 || model < -8 then style "color" "red" else style "color" "black"
  in
    div []
      [ button [ bigFont, onClick Increment, disabled (model >= 10) ] [ text "+" ]
      , div [ bigFont, textColor ] [ text (String.fromInt model) ]
      , button [ bigFont, onClick Decrement, disabled (model <= -10)  ] [ text "-" ]
      ]
