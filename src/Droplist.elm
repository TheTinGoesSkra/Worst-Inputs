module Droplist exposing (Model, Msg(..), addZeros, init, initCmd, initModel, main, subscriptions, update, updateCmd, updateModel, view, viewOption)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


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
    = Increment
    | Decrement
    | Yes


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
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

        Yes ->
            { model | alert = "Thank you, nonce!" }


updateCmd : Msg -> Model -> Cmd Msg
updateCmd msg model =
    Cmd.none


view : Model -> Html Msg
view model =
    div []
        [ div [ class "display-4", style "margin-bottom" "40px" ] [ text "Choose your phone number, you twat." ]
        , select [] (List.map (viewOption 3) (List.range 0 999))
        , select [] (List.map (viewOption 3) (List.range 0 999))
        , select [] (List.map (viewOption 2) (List.range 0 99))
        , select [] (List.map (viewOption 2) (List.range 0 99))
        , button [ onClick Yes ] [ text "Submit" ]
        , div [] [ text <| model.alert ]
        ]


viewOption length n =
    option [ value (addZeros length (String.fromInt n)) ] [ text (addZeros length (String.fromInt n)) ]


addZeros : Int -> String -> String
addZeros length num =
    String.repeat (length - String.length num) "0" ++ num
