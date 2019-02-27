module PrimeNumbers exposing (Model, Msg(..), addZeros, division, init, initCmd, initModel, main, possibleNumbers, subscriptions, update, updateCmd, updateModel, view)

import Browser
import Html exposing (Attribute, Html, button, div, h1, h3, input, text, h2, h4, h5, h6)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


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



-- MODEL


type alias Model =
    { content : String
    , count : Int
    , alert : String
    }


initModel : Model
initModel =
    { content = "", count = 1, alert = "" }



-- UPDATE


type Msg
    = Change String
    | Multiply
    | Submit
    | Reset


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }

        Multiply ->
            case String.toInt model.content of
                Just num ->
                    if List.any (division num) (possibleNumbers num) then
                        { model | alert = "That ain't no prime number, plonker!" }

                    else if num * model.count < 9999999999 then
                        { model | count = num * model.count, alert = "" }

                    else
                        model

                Nothing ->
                    { model | alert = "Gotta insert a number, cunt!" }

        Submit ->
            { model | alert = "Thank you!" }

        Reset ->
            { model | count = 1 }


possibleNumbers : Int -> List Int
possibleNumbers num =
    List.range 2 (num - 1)


division : Int -> Int -> Bool
division num1 num2 =
    if modBy num2 num1 == 0 then
        True

    else
        False


addZeros : Int -> String -> String
addZeros length num =
    String.repeat (length - String.length num) "0" ++ num



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [ class "display-4", style "margin-bottom" "0" ] [ text "2 is the only even prime number." ]
        , h5 [ style "margin-bottom" "40px" ] [ text "It's kind of odd, isn't it?" ]
        , input [ placeholder "Insert a prime number", value model.content, onInput Change ] []
        , div [] [ text <| addZeros 10 (String.fromInt model.count) ]
        , button [ onClick Multiply ] [ text "Multiply" ]
        , button [ onClick Submit ] [ text "Submit" ]
        , button [ onClick Reset ] [ text "Reset" ]
        , div [] [ text <| model.alert ]
        ]
