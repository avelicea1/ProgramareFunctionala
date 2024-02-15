module Inputs exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (checked, placeholder, style, type_, value, disabled, class)
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

accountTypeToString : AccountType -> String
accountTypeToString ty =
    case ty of
        User ->
            "User"

        Admin ->
            "Admin"


accountTypeFromString : String -> Maybe AccountType
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
    , passwordRepeat : String
    , passwordMatch : Bool
    , passwordValidationError : Maybe String
    , emailAddress : Maybe String
    }


type Msg
    = SelectedValue String
    | UsernameChanged String
    | PasswordChanged String
    | PasswordRepeatChanged String
    | SetActivateAccount Bool
    | PasswordValidationError (Maybe String)


init : () -> ( Model, Cmd Msg )
init _ =
    ( { accountType = User, activateAccount = False, username = "", password = "", passwordRepeat = "", passwordMatch = True, passwordValidationError = Nothing, emailAddress = Nothing }
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
            let
                match = password == model.passwordRepeat
                minLength =
                    case model.accountType of
                        User ->
                            8

                        Admin ->
                            12

                validationError =
                    if String.length password < minLength then
                        Just ("Password must have at least " ++ String.fromInt minLength ++ " characters.")
                    else
                        Nothing
            in
            ( { model | password = password, passwordMatch = match, passwordValidationError = validationError }
            , Cmd.none
            )

        PasswordRepeatChanged passwordRepeat ->
            let
                match = passwordRepeat == model.password
            in
            ( { model | passwordRepeat = passwordRepeat, passwordMatch = match, passwordValidationError = Nothing }
            , Cmd.none
            )

        SetActivateAccount activate ->
            ( { model | activateAccount = activate }
            , Cmd.none
            )

        PasswordValidationError maybeError ->
            ( { model | passwordValidationError = maybeError }
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
accountDetailsView { username, password, passwordRepeat, passwordMatch, passwordValidationError } =
    let
        inputAttrs ty p v msg =
            [ type_ ty, placeholder p, value v, onInput msg ]
        passwordDiv =
            div []
                [ input (inputAttrs "password" "Repeat Password" passwordRepeat PasswordRepeatChanged) []
                , case passwordValidationError of
                    Just error ->
                        div [ style "color" "red" ] [ text error ]

                    Nothing ->
                        div [] []
                ]
    in
    div []
        [ input (inputAttrs "text" "username" username UsernameChanged) []
        , input (inputAttrs "password" "password" password PasswordChanged) []
        , passwordDiv
        , div [ class "password-message" ] [ passwordMessage passwordMatch ]
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
        , p [] [ text "Password Match: ", text <| if model.passwordMatch then "1" else "0" ]
        , p []
            [ text <|
                if model.activateAccount then
                    "Account will be created activated"
                else
                    "Account will be created suspended"
            ]
        ]


passwordMessage : Bool -> Html Msg
passwordMessage match =
    if match then
        div [ style "color" "green" ] [ text "Passwords match" ]
    else
        div [ style "color" "red" ] [ text "Passwords do not match" ]


view : Model -> Html Msg
view model =
    div []
        [ statusView model
        , accountTypeView
        , activateAccountView model.activateAccount
        , accountDetailsView model
        , button [ disabled <| String.isEmpty model.username || String.isEmpty model.password || not model.passwordMatch || (model.passwordValidationError /= Nothing) ] [ text "Create Account"]
        ]
