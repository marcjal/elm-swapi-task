module Model exposing
    ( Model
    , initialModel
    )

import Browser.Navigation as Nav
import Web.Detail.Model as Detail
import Web.Home.Model as Home
import Page exposing (Page(..))


type alias Model =
    { page : Page
    , key : Nav.Key
    , homeModel: Home.Model
    , detailModel : Detail.Model
    }


initialModel : Nav.Key -> Model
initialModel key =
    { page = Home
    , key = key
    , homeModel = Home.initialModel
    , detailModel = Detail.initialModel
    }
