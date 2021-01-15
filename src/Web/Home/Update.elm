module Web.Home.Update exposing (Msg(..), update)

import GlobalMessage.OutMessage exposing (OutMessage(..))
import Web.Home.Model exposing (..)
import Http


type Msg
    = OnEnter


update : Msg -> Model -> ( Model, Cmd Msg, List OutMessage )
update msg model =
    case msg of
        OnEnter ->
            ( model
            , Cmd.none
            , []
            )
