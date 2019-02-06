module RandomNumber exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Random

main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { count : Int, alert : String }


type Msg
    = No
    | Yes
    | Roll Int


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , initCmd
    )


initCmd : Cmd Msg
initCmd =
    Random.generate Roll roll 


initModel : Model
initModel =
    { count = 0, alert = "" }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateModel msg model, updateCmd msg model )


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        
        No ->
            { model | count = model.count + 1, alert = "Or this one?" }

        Yes ->
            { model | alert = "Thank you!" }
            
        Roll num ->
            { model | count = num }


updateCmd : Msg -> Model -> Cmd Msg
updateCmd msg model =
    case msg of
        No ->
            Random.generate Roll roll

        Yes ->
            Cmd.none
            
        Roll num ->
            Cmd.none


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "Is this your phone number?" ]
        , button [ onClick No ] [ text "No" ]
        , div [] [ text <| String.fromInt model.count ]
        , button [ onClick Yes ] [ text "Yes" ]
        , div [] [ text <| model.alert ]
        ]
  
  
roll : Random.Generator Int
roll =
  Random.int 1 9999999999
