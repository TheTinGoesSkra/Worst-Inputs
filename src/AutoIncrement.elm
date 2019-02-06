module AutoIncrement exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Utils
import Time


main =
    Browser.element
        { init = init
        , view = Utils.embedView view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { count : Int, numbers : List Int }


type Msg
    = Ok
    | Tick Time.Posix


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
    { count = 0, numbers = [] }


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 300 Tick


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateModel msg model, updateCmd msg model )


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        Ok ->
            { model | numbers = model.numbers ++ [model.count] }

        Tick time ->
            { model | count = modBy 10 (model.count + 1) }


updateCmd : Msg -> Model -> Cmd Msg
updateCmd msg model =
    Cmd.none


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Ok ] [ text "Ok" ]
        , div [] [ text <| String.fromInt model.count ]
        , div [] [text <| Debug.toString <| model.numbers]
        ]
