module Web.Home.Model exposing (Model, initialModel)

import Data.SWAPI exposing (StarWars)

type alias Model =
    { starWarstInfoResultInfo : List StarWars
    }


initialModel : Model
initialModel =
    { starWarstInfoResultInfo = []
    }
