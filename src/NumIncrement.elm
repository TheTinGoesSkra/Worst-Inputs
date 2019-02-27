module NumIncrement exposing (Model, Msg(..), addZeros, init, initCmd, initModel, main, separateString, subscriptions, update, updateCmd, updateModel, view)

import Browser
import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , initCmd
    )


initCmd : Cmd Msg
initCmd =
    Cmd.none


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateModel msg model, updateCmd msg model )


updateCmd : Msg -> Model -> Cmd Msg
updateCmd msg model =
    Cmd.none


type alias Model =
    { count : Int, message : String }


initModel : Model
initModel =
    { count = 1, message = "" }


type Msg
    = Increment
    | Submit


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Submit ->
            { model | message = "Took you long enough" }


view : Model -> Html Msg
view model =
    div []
        [ div [ class "display-4", style "margin-bottom" "40px" ] [ text "Would you be so kind and enter you damn phone number!" ]
        , button [ onClick Increment ] [ text "+1" ]
        , div [] [ text <| separateString <| addZeros 10 <| String.fromInt model.count ]
        , button [ onClick Submit ] [ text "I gotcha!" ]
        , div [] [ text <| model.message ]
        ]


addZeros : Int -> String -> String
addZeros length num =
    String.repeat (length - String.length num) "0" ++ num


separateString : String -> String
separateString s =
    String.slice 0 3 s
        ++ " "
        ++ String.slice 3 6 s
        ++ " "
        ++ String.slice 6 8 s
        ++ " "
        ++ String.slice 8 10 s


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
