module Rest.SWAPI exposing (getCharacters, getPlanets, getSpecies, getStarWarsInfo, getStarships, getVehicles)

import Data.SWAPI exposing (StarWars, Characters, Planets, Starships, Vehicles, Species)
import Http
import HttpBuilder exposing (..)
import HttpBuilder.Task exposing (..)
import Json.Decode exposing (Decoder, andThen, at, fail, field, int, list, maybe, string, succeed)
import Json.Decode.Pipeline exposing (hardcoded, optionalAt, required, requiredAt)
import Json.Encode
import Task as Task exposing (Task)


type DataError
    = NoCharacters
    | NoPlanets


type Error
    = HttpError Http.Error
    | DataError DataError


getStarWarsInfoURL : String
getStarWarsInfoURL =
    "https://swapi.dev/api/films/"


getStarWarsInfo : (Result Http.Error (List StarWars) -> msg) -> Cmd msg
getStarWarsInfo msg =
    HttpBuilder.get getStarWarsInfoURL
        |> HttpBuilder.withExpect (Http.expectJson msg decodeStarWarsInfo)
        |> HttpBuilder.request


decodeStarWarsInfo : Decoder (List StarWars)
decodeStarWarsInfo =
    at [ "results" ] (Json.Decode.list decodeStarWars)


decodeStarWars : Decoder StarWars
decodeStarWars =
    succeed StarWars
        |> requiredAt [ "title" ] string
        |> requiredAt [ "opening_crawl" ] string
        |> requiredAt [ "director" ] string
        |> requiredAt [ "release_date" ] string
        |> requiredAt [ "characters" ] (list string)
        |> requiredAt [ "planets" ] (list string)
        |> requiredAt [ "starships" ] (list string)
        |> requiredAt [ "vehicles" ] (list string)
        |> requiredAt [ "species" ] (list string)


getCharacters : String -> (Result Http.Error Characters -> msg) -> Cmd msg
getCharacters id msg =
    Http.get
        { url = "http://swapi.dev/api/people/" ++ id ++ "/"
        , expect = Http.expectJson msg decodeCharacters
        }


decodeCharacters : Decoder Characters
decodeCharacters =
    Json.Decode.map2 Characters
        (field "name" string)
        (field "birth_year" string)


getPlanets : String -> (Result Http.Error Planets -> msg) -> Cmd msg
getPlanets id msg =
    Http.get
        { url = "http://swapi.dev/api/planets/" ++ id ++ "/"
        , expect = Http.expectJson msg decodePlanets
        }


decodePlanets : Decoder Planets
decodePlanets =
    Json.Decode.map3 Planets
        (field "name" string)
        (field "climate" string)
        (field "terrain" string)


getStarships : String -> (Result Http.Error Starships -> msg) -> Cmd msg
getStarships id msg =
    Http.get
        { url = "http://swapi.dev/api/starships/" ++ id ++ "/"
        , expect = Http.expectJson msg decodeStarships
        }


decodeStarships : Decoder Starships
decodeStarships =
    Json.Decode.map3 Starships
        (field "name" string)
        (field "model" string)
        (field "manufacturer" string)


getVehicles : String -> (Result Http.Error Vehicles -> msg) -> Cmd msg
getVehicles id msg =
    Http.get
        { url = "http://swapi.dev/api/vehicles/" ++ id ++ "/"
        , expect = Http.expectJson msg decodeVehicles
        }


decodeVehicles : Decoder Vehicles
decodeVehicles =
    Json.Decode.map3 Vehicles
        (field "name" string)
        (field "model" string)
        (field "manufacturer" string)


getSpecies : String -> (Result Http.Error Species -> msg) -> Cmd msg
getSpecies id msg =
    Http.get
        { url = "http://swapi.dev/api/species/" ++ id ++ "/"
        , expect = Http.expectJson msg decodeSpecies
        }


decodeSpecies : Decoder Species
decodeSpecies =
    Json.Decode.map3 Species
        (field "name" string)
        (field "classification" string)
        (field "designation" string)


-- decodeRawStarWarsData : Decoder RawStarWarsData
-- decodeRawStarWarsData =
--     Json.Decode.map3 RawStarWarsData
--         (field "name" string)
--         (field "characters" (list string))
--         (field "planets" (list string))


-- getRawStarWarsData : Task Http.Error RawStarWarsData
-- getRawStarWarsData =
--     Http.task
--         { method = "GET"
--         , headers = []
--         , url = "https://swapi.dev/api/films/"
--         , body = Http.emptyBody
--         , resolver = Http.stringResolver (handleJsonResponse decodeRawStarWarsData)
--         , timeout = Nothing
--         }



-- getStarWarsData : Task Http.Error StarWarsData
-- getStarWarsData =
--     getRawStarWarsData
--         |> Task.andThen makeMoreRequests


-- getCharactersTask : String -> Task Http.Error (Decoder Characters)
-- getCharactersTask id =
--     Http.task
--         { method = "GET"
--         , headers = []
--         , url = "http://swapi.dev/api/people/" ++ id ++ "/"
--         , body = Http.emptyBody
--         , resolver = Http.stringResolver <| handleJsonResponse <| Json.Decode.succeed decodeCharacters
--         , timeout = Nothing
--         }


-- getPlanetsTask : String -> Task Http.Error (Decoder Planets)
-- getPlanetsTask id =
--     Http.task
--         { method = "GET"
--         , headers = []
--         , url = "http://swapi.dev/api/planets/" ++ id ++ "/"
--         , body = Http.emptyBody
--         , resolver = Http.stringResolver <| handleJsonResponse <| Json.Decode.succeed decodePlanets
--         , timeout = Nothing
--         }


-- makeMoreRequests : RawStarWarsData -> Task Http.Error StarWarsData
-- makeMoreRequests rawData =
--     Task.map2 (combineData rawData)
--         (Task.sequence (List.map getCharactersTask rawData.characters))
--         (Task.sequence (List.map getPlanetsTask rawData.planets))


-- combineData : RawStarWarsData -> List Characters -> List Planets -> StarWarsData
-- combineData rawData characters planets =
--     { name = rawData.name
--     , characters = characters
--     , planets = planets
--     }


-- handleJsonResponse : Decoder a -> Http.Response String -> Result Http.Error a
-- handleJsonResponse decoder response =
--     case response of
--         Http.BadUrl_ url ->
--             Err (Http.BadUrl url)
--         Http.Timeout_ ->
--             Err Http.Timeout
--         Http.BadStatus_ { statusCode } _ ->
--             Err (Http.BadStatus statusCode)
--         Http.NetworkError_ ->
--             Err Http.NetworkError
--         Http.GoodStatus_ _ body ->
--             case Json.Decode.decodeString decoder body of
--                 Err _ ->
--                     Err (Http.BadBody body)
--                 Ok result ->
--                     Ok result