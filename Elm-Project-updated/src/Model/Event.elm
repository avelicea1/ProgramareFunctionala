module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"


sortByInterval : List Event -> List Event
sortByInterval events =
    let
        compareEvents : Event -> Event -> Order
        compareEvents a b =
            Interval.compare a.interval b.interval
    in
        List.sortWith compareEvents events
    -- events
    -- Debug.todo "Implement Event.sortByInterval"


view : Event -> Html Never
view event =
    let
        eventClass importance = 
            if importance == True then 
                "event event-important"
            else 
                "event"
        getUrl url = 
            case url of 
                Just a -> a
                Nothing -> ""
    in 
    div[class (eventClass event.important)]
        [ h3 [ class "event-title" ] [ text event.title ]
        , div [ class "event-interval" ] [ Interval.view event.interval ]
        , p [ class "event-description" ] [ event.description]
        , p [ class "event-category" ] [ categoryView event.category ]
        , p [ class "event-url" ] [ text (Maybe.withDefault "" event.url) ]
        , p [] [ text "Tags" ]
        , ul [] (List.map (\x -> li [] [ text x ]) event.tags)
        ]
    -- div [] []
    -- Debug.todo "Implement the Model.Event.view function"
