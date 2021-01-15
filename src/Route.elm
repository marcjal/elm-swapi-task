module Route exposing (Route(..), parser)

import Browser.Navigation as Navigation exposing (load)
import Page exposing (Page(..))
import String
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, s)

type Route
    = Root
    | Details String


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Root Parser.top
        , Parser.map Details (s "movie" </> Parser.string)
        ]

navigate : Page -> Cmd msg
navigate page =
    locationFromPage page
        |> Navigation.load


locationFromPage : Page -> String
locationFromPage page =
    case page of
        Home ->
            "#/home"
        Detail id ->
            "#/movie/" ++ id
        NotFound ->
            "#/"