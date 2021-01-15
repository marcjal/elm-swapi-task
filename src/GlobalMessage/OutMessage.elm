module GlobalMessage.OutMessage exposing (OutMessage(..))

type OutMessage
    = Growl String String
    | GrowlError String
