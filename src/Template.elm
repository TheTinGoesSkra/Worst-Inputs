module Template exposing (Model, Msg(..), init, initCmd, initModel, main, subscriptions, update, updateCmd, updateModel, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Utils


main =
    Browser.element
        { init = init
        , view = Utils.embedView view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { count : Int }


type Msg
    = Increment
    | Decrement


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , initCmd
    )


initCmd : Cmd Msg
initCmd =
    Cmd.none


initModel : Model
initModel =
    { count = 0 }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateModel msg model, updateCmd msg model )


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }


updateCmd : Msg -> Model -> Cmd Msg
updateCmd msg model =
    Cmd.none


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+1" ]
        , div [] [ text <| String.fromInt model.count ]
        , button [ onClick Decrement ] [ text "-1" ]
        ]
