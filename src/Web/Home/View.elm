module Web.Home.View exposing (view)

import Data.SWAPI exposing (StarWars)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Json.Decode exposing (index)
import Web.Home.Model exposing (Model)


view : Model -> Html msg
view model =
    div [ class "sc-gqjmRU gOWMvv" ]
        [ div [ class "sc-VigVT evBinc" ]
            (model.starWarstInfoResultInfo
                |> List.indexedMap (\i movie -> viewSWCard i movie)
            )
        ]


viewSWCard : Int -> StarWars -> Html msg
viewSWCard index { title, openingCrawl, director, releaseDate } =
    let
        newIndex =
            String.fromInt (index + 1)
    in
    div [ class "sc-jTzLTM sc-kGXeez cxotUj" ]
        [ div [ class "sc-kpOJdX cnKyIi" ]
            [ div [ class "sc-jzJRlG bUZhwK" ]
                [ h3 [ class "sc-cSHVUG kGUMfd" ]
                    [ a [ href ("/movie/" ++ newIndex) ]
                        [ text title ]
                    ]
                , span [ class "sc-kAzzGY kOazVl" ]
                    [ text director ]
                , span [ class "sc-kAzzGY kOazVl" ]
                    [ text releaseDate ]
                ]
            , p [ class "sc-chPdSV PAWvw" ]
                [ text openingCrawl ]
            , p [ class "sc-kgoBCf bSjpwl" ]
                [ a [ href ("/movie/" ++ newIndex) ]
                    [ text "More info" ]
                ]
            ]
        ]
