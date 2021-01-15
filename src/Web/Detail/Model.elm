module Web.Detail.Model exposing (Model, initialModel)

import Data.SWAPI exposing (Characters, Planets, Starships, Vehicles, Species)

type alias Model =
    { charactersInfo : Maybe Characters
    , planetsInfo : Maybe Planets
    , starshipsInfo : Maybe Starships
    , vehiclesInfo : Maybe Vehicles
    , speciesInfo : Maybe Species
    }


initialModel : Model
initialModel =
    { charactersInfo = Nothing
    , planetsInfo = Nothing
    , starshipsInfo = Nothing
    , vehiclesInfo = Nothing
    , speciesInfo = Nothing
    }