module View exposing (view)

import Browser exposing (Document)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events exposing (..)
import Html.Lazy exposing (lazy)
import Maybe.Extra
import Model exposing (Model)
import Page exposing (Page(..))
import Update exposing (Msg(..))
import Web.Detail.View as Detail exposing (view)
import Web.Home.View as Home exposing (view)


view : Model -> Document Msg
view model =
    let
        content =
            case model.page of
                Home ->
                    Home.view model.homeModel

                Detail _ ->
                    Detail.view

                NotFound ->
                    text "Not Found"
    in
    { title = "SWAPI Elm Task"
    , body =
        [ viewHeader
        , content
        ]
    }


viewHeader : Html Msg
viewHeader =
    header [ class "sc-bdVaJa exsxfJ" ]
        [ a [ href "https://ibb.co/qm9vYjP" ]
            [ img [ src "https://i.ibb.co/CVvfK8T/starwars.png", alt "starwars" ]
                []
            ]
        ]
