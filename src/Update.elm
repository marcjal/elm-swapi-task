module Update exposing (Msg(..), update, updateUrl)

import Browser
import Browser.Navigation as Nav
import Data.SWAPI exposing (StarWars)
import Http
import List.Extra as List exposing (getAt)
import Model exposing (Model)
import GlobalMessage.OutMessage exposing (OutMessage(..))
import OutMessage
import Page exposing (Page(..))
import Rest.SWAPI exposing (getStarWarsInfo, getCharacters, getPlanets, getSpecies, getStarships, getVehicles)
import Route exposing (Route(..), parser)
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser)
import Web.Detail.Update as DUpdate


type Msg
    = ClickedLink Browser.UrlRequest
    | UrlChange Url
    | StarWarstInfoResult (Result Http.Error (List StarWars))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink urlRequest ->
            case urlRequest of
                Browser.External href ->
                    ( model, Nav.load href )

                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

        UrlChange url ->
            updateUrl url model

        StarWarstInfoResult (Ok starWarstInfoResultInfo) ->
            let
                homeModel =
                    model.homeModel

                newHomeModel =
                    { homeModel | starWarstInfoResultInfo = starWarstInfoResultInfo }

                newModel =
                    { model | homeModel = newHomeModel }
            in
            ( newModel, Cmd.none )

        StarWarstInfoResult (Err error) ->
            ( model, Cmd.none )


updateUrl : Url -> Model -> ( Model, Cmd Msg )
updateUrl url model =
    case Parser.parse parser url of
        Just Root ->
            ( { model | page = Home }, getStarWarsInfo StarWarstInfoResult )

        Just (Details id) ->
            let
                newID =
                    (String.toInt id |> Maybe.withDefault 0) - 1

            in
            ( { model | page = Detail id }, Cmd.none )
        Nothing ->
            ( { model | page = NotFound }, Cmd.none )


interpretOutMsg : GlobalMessage.OutMessage.OutMessage -> Model -> ( Model, Cmd Msg )
interpretOutMsg outMsg model =
    case outMsg of
        Growl title content ->
            (model, Cmd.none)

        GrowlError error ->
            (model, Cmd.none)
