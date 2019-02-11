module Main exposing (main)

import Browser
import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 1 }

type Msg
    = Increment


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Please enter your phone number!" ]
        , button [ onClick Increment ] [ text "+1" ]
        , div [] [ text <| separateString <| addZeros 10 <| String.fromInt model.count ]
        --, button [] [ text "Submit" ]
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


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }