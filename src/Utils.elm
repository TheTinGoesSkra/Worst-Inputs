module Utils exposing (embedView)

import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Html exposing (..)


-- embeds the view so that bootstrap can be used, only used for testing
embedView : (model -> Html msg) -> (model -> Html msg)
embedView view model =
    Grid.container []
        [ CDN.stylesheet
        , view model
        ]
