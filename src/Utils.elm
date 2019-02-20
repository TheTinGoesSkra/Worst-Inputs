module Utils exposing (..)

import Html exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid

embedView : (model -> Html msg) -> (model -> Html msg)
embedView view model =
    Grid.container []
        [ CDN.stylesheet 
        , view model
        ]
        