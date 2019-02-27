module AutoIncrement exposing (Model, Msg(..), fillTo10, init, initCmd, initModel, listIntToListString, main, makeListIntToListStringAndWithLength10, subscriptions, update, updateCmd, updateModel, view, viewBox)

import Bootstrap.Button as Button
import Bootstrap.Utilities.Spacing as Spacing
import Browser
import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (style, class)
import Html.Events exposing (onClick)
import Time
import Utils


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
    | Reset
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
    Time.every 100 Tick


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateModel msg model, updateCmd msg model )


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        Ok ->
            if List.length model.numbers < 10 then
                { model | numbers = model.numbers ++ [ model.count ], count = 0 }

            else
                model

        Reset ->
            { model | numbers = [] }

        Tick time ->
            { model | count = modBy 10 (model.count + 1) }


updateCmd : Msg -> Model -> Cmd Msg
updateCmd msg model =
    Cmd.none


listIntToListString : List Int -> List String
listIntToListString l =
    List.map String.fromInt l


fillTo10 : List String -> List String
fillTo10 l =
    let
        len =
            List.length l
    in
    l ++ List.repeat (10 - len) ""


makeListIntToListStringAndWithLength10 : Model -> List String
makeListIntToListStringAndWithLength10 model =
    let
        len =
            List.length model.numbers
    in
    if len < 10 then
        fillTo10 <| listIntToListString <| model.numbers ++ [ model.count ]

    else
        fillTo10 <| listIntToListString model.numbers


view : Model -> Html Msg
view model =
    div []
        [ div [ class "display-4", style "margin-bottom" "40px" ] [ text "You gotta go fast" ]
        , Button.button [ Button.secondary, Button.attrs [ onClick Ok ] ] [ text "Ok" ]
        , Button.button [ Button.danger, Button.attrs [ onClick Reset ] ] [ text "Reset" ]
        , div [] (List.map viewBox <| makeListIntToListStringAndWithLength10 model)
        ]


viewBox : String -> Html Msg
viewBox num =
    div
        [ style "display" "inline-block"
        , style "height" "100px"
        , style "width" "100px"
        , style "text-align" "center"
        , style "vertical-align" "middle"
        , style "line-height" "100px"
        , style "border" "solid"
        , style "font-size" "50px"
        ]
        [ text num ]
