module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, id, href)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }


view : PersonalDetails -> Html msg
view details =
    div[]
        [h1 [id "name"] [text details.name]
        ,em [id "intro"] [text details.intro],
        div [class "contact-detail"] (List.map (\x -> p [] [text x.detail]) details.contacts),
        div [class "social-link"] (List.map(\x -> p [] [a [href x.detail][text x.detail]])details.socials)
        ]
    -- div [] []
    -- Debug.todo "Implement the Model.PersonalDetails.view function"
