module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Model exposing ( Model, initialModel)
import Update exposing (Msg(..), update, updateUrl)
import Url exposing (Url)
import View


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    updateUrl url (initialModel key)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChange
        , subscriptions = \_ -> Sub.none
        , update = Update.update
        , view = View.view
        }
