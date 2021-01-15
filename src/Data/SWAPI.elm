module Data.SWAPI exposing (StarWars, Characters, Planets, Starships, Vehicles, Species, StarWarsData, RawStarWarsData)

type alias StarWars =
    { title : String
    , openingCrawl : String
    , director : String
    , releaseDate : String
    , characters : List String
    , planets : List String
    , starships : List String
    , vehicles : List String
    , species : List String
    }


type alias Characters =
    { name : String
    , birthYear : String
    }


type alias Planets =
    { name : String
    , climate : String
    , terrain : String
    }


type alias Starships =
    { name : String
    , model : String
    , manufacturer : String
    }


type alias Vehicles =
    { name : String
    , model : String
    , manufacturer : String
    }


type alias Species =
    { name : String
    , classification : String
    , designation : String
    }

type alias StarWarsData =
    { name : String
    , characters : List Characters
    , planets : List Planets
    }


type alias RawStarWarsData =
    { name : String
    , characters : List String
    , planets : List String
    }
