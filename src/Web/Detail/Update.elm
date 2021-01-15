module Web.Detail.Update exposing (Msg(..), update)

import Web.Detail.Model exposing (..)
import Http
import Rest.SWAPI exposing (getStarWarsInfo, getCharacters, getPlanets, getSpecies, getStarships, getVehicles)
import Task exposing (Task)


type Msg
    = OnEnter Int
    | NoOp

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnEnter id ->
            ( model, Cmd.none)

        NoOp ->
            ( model, Cmd.none )