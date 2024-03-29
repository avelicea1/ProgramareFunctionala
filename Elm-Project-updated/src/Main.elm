module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Http
import Json.Decode as De
import Model exposing (..)
import Model.Event as Event
import Model.Event.Category as EventCategory
import Model.PersonalDetails as PersonalDetails
import Model.Repo as Repo


type Msg
    = GetRepos
    | GotRepos (Result Http.Error (List Repo.Repo))
    | SelectEventCategory EventCategory.EventCategory
    | DeselectEventCategory EventCategory.EventCategory


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

getRepos : Cmd Msg
    
getRepos = 
    let
        getHead social =
           List.head social
        getUrl head =
           case head of
              Just x -> x.detail
              Nothing -> ""
    in
    Http.get
    { url = getUrl (getHead Model.personalDetails.socials)
    , expect = Http.expectJson GotRepos (De.list Repo.decodeRepo)
    }
init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , getRepos
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetRepos ->
            ( model, Cmd.none )
        GotRepos res ->
            case res of
                Ok repos ->
                    ({ model | repos = repos }, Cmd.none)

                Err _ ->
                    (model, Cmd.none)

        SelectEventCategory category ->
            let
                newSelectedCategories =
                    EventCategory.set category True model.selectedEventCategories
            in
            ({ model | selectedEventCategories = newSelectedCategories }, Cmd.none)

        DeselectEventCategory category ->
            let
                newSelectedCategories =
                    EventCategory.set category False model.selectedEventCategories
            in
            ({ model | selectedEventCategories = newSelectedCategories }, Cmd.none)

eventCategoryToMsg : ( EventCategory.EventCategory, Bool ) -> Msg
eventCategoryToMsg ( event, selected ) =
    if selected then
        SelectEventCategory event

    else
        DeselectEventCategory event


view : Model -> Html Msg
view model =
    let
        eventCategoriesView =
            EventCategory.view model.selectedEventCategories |> Html.map eventCategoryToMsg

        eventsView =
            model.events
                |> List.filter (.category >> (\cat -> EventCategory.isEventCategorySelected cat model.selectedEventCategories))
                |> List.map Event.view
                |> div []
                |> Html.map never

        reposView =
            model.repos
                |> Repo.sortByStars
                |> List.take 5
                |> List.map Repo.view
                |> div []
    in
    div []
        [ PersonalDetails.view model.personalDetails
        , h2 [] [ text "Experience" ]
        , eventCategoriesView
        , eventsView
        , h2 [] [ text "My top repos" ]
        , reposView
        ]
