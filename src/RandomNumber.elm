module RandomNumber exposing (Model, Msg(..), init, initCmd, initModel, main, roll, subscriptions, update, updateCmd, updateModel, view)

import Browser
import Html exposing (Html, button, div, h1, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
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
            { model | count = model.count + 1, alert = "This one alright, bugger?" }

        Yes ->
            { model | alert = "Thanks to ye, clunge!" }

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
        [ div [ class "display-4", style "margin-bottom" "40px" ] [ text "That your phone number, mate?" ]
        , button [ onClick No ] [ text "No, gimme another" ]
        , div [] [ text <| String.fromInt model.count ]
        , button [ onClick Yes ] [ text "Yeah" ]
        , div [] [ text <| model.alert ]
        ]


roll : Random.Generator Int
roll =
    Random.int 1 9999999999
