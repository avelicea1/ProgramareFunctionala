module Inputs exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (checked, placeholder, style, type_, value, disabled)
import Html.Events exposing (..)


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type AccountType
    = User
    | Admin


accountTypes : List AccountType
accountTypes = [User, Admin]

accountTypeToString ty =
    case ty of
        User ->
            "User"

        Admin ->
            "Admin"


accountTypeFromString s =
    case String.toLower s of
        "user" ->
            Just User

        "admin" ->
            Just Admin

        _ ->
            Nothing


type alias Model =
    { accountType : AccountType
    , activateAccount : Bool
    , username : String
    , password : String
    , repeatPassword: String
    , emailAddress : Maybe String
    }



type Msg
    = SelectedValue String
    | UsernameChanged String
    | PasswordChanged String
    | RepeatPasswordChanged String
    | SetActivateAccount Bool


init : () -> ( Model, Cmd Msg )
init _ =
    ( { accountType = User, activateAccount = False, username = "", password = "", repeatPassword="", emailAddress = Nothing }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectedValue s ->
            ( { model | accountType = accountTypeFromString s |> Maybe.withDefault User }
            , Cmd.none
            )

        UsernameChanged username ->
            ( { model | username = username }
            , Cmd.none
            )

        PasswordChanged password ->
            ( { model | password = password }
            , Cmd.none
            )

        RepeatPasswordChanged repeatPassword -> 
            ( { model | repeatPassword = repeatPassword }
            , Cmd.none
            )

        SetActivateAccount activate ->
            ( { model | activateAccount = activate }
            , Cmd.none
            )




accountTypeView : Html Msg
accountTypeView =
    div []
        [ select [ Html.Events.onInput SelectedValue ]
            [ option [ value "User" ] [ text "User" ]
            , option [ value "Admin" ] [ text "Admin" ]
            ]
        ]




accountDetailsView : Model -> Html Msg
accountDetailsView { username, password, repeatPassword} =
    let
        inputAttrs ty p v msg =
            [ type_ ty, placeholder p, value v, onInput msg ]
    in
    div []
        [ input (inputAttrs "text" "username" username UsernameChanged) []
        , input (inputAttrs "password" "password" password PasswordChanged) []
        , input (inputAttrs "password" "repeat password" repeatPassword RepeatPasswordChanged) []
        , button [disabled ((String.length username == 0) || (String.length password == 0) || (password /= repeatPassword))] [text "Create Account"]
        ]
 



activateAccountView : Bool -> Html Msg
activateAccountView yes =
    div []
        [ input [ type_ "checkbox", onCheck SetActivateAccount, checked yes ] []
        , text "Activate account?"
        ]



statusView : Model -> Html Msg
statusView model =
    div []
        [ p [] [ text "Account type: ", text <| accountTypeToString model.accountType ]
        , p [] [ text "Username: ", text model.username ]
        , p [] [ text "Password: ", text model.password ]
        , p [] [ text "Repeat password: ", text model.repeatPassword]
        , p [style "color" <| if model.password == model.repeatPassword then "green" else "red"] 
            [ text <|
                if model.password == model.repeatPassword then
                    "Passwords match"

                else
                    "Passwords don't match"
            ]
        , p []
            [ text <|
                if model.activateAccount then
                    "Account will be created activated"

                else
                    "Account will be created suspended"
            ]
        ]

view : Model -> Html Msg
view model =
    div []
        [ statusView model
        , accountTypeView
        , activateAccountView model.activateAccount
        , accountDetailsView model
        ]
