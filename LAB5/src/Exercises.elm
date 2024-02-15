module Exercises exposing (..)

import Theme exposing (ThemeConfig(..))


type alias UserDetails = 
  { firstName: String
  , lastName: String
  , phoneNumber: Maybe String
  }
type alias User = {id: String, email: String, details: UserDetails}


makeUser id email firstName lastName phoneNumber = 
  User id email (UserDetails firstName lastName phoneNumber)

usersWithPhoneNumbers : List User -> List String
usersWithPhoneNumbers users =
    users
        |> List.filter (\user -> user.details.phoneNumber /= Nothing)
        |> List.map .email


type alias AccountConfiguration = 
  { preferredTheme: ThemeConfig
  , subscribedToNewsletter: Bool
  , twoFactorAuthOn: Bool
  }

changePreferenceToDarkTheme : List AccountConfiguration -> List AccountConfiguration
changePreferenceToDarkTheme accounts =
    List.map
        (\account ->
            { account | preferredTheme = Theme.Dark }
        )
        accounts
