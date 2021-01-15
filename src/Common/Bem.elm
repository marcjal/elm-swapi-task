module Common.Bem exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (class)
import String exposing (join)
import List exposing (..)
import Tuple exposing (..)


-- BEM formatting utilities to avoid verboseness
-- http://getbem.com/


type alias ClassName =
    String


type alias Modifier =
    ( ClassName, Bool )


active : Modifier -> Bool
active =
    second


addMod : ClassName -> ClassName -> ClassName
addMod base =
    (++) (base ++ "--")


bem : ClassName -> List Modifier -> Attribute msg
bem base =
    filter active
        >> map (first >> (addMod base))
        >> (::) base
        >> join " "
        >> class


bem1 : ClassName -> Modifier -> Attribute msg
bem1 base mod =
    bem base [ mod ]
