module Common.Basics exposing (verify, maybeToBool, noEff)


verify : Bool -> a -> a -> a
verify conditional trueCase falseCase =
    if conditional then
        trueCase
    else
        falseCase


noEff : a -> ( a, Cmd msg, List b )
noEff m =
    ( m, Cmd.none, [] )


maybeToBool : Maybe a -> Bool
maybeToBool =
    Maybe.map (always True) >> Maybe.withDefault False
