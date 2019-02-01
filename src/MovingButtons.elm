module MovingButtons exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

import Task
import Time
import Random
import Browser
main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Position =
    { x : Float, y : Float, direction : Int}

type alias Positions =
    List Position

type alias Model =
    { numbers : List Int
    , positions : Positions}


init : () -> (Model, Cmd Msg)
init _ =
  ( initialModel
  , (Random.generate RandomPositions initPositions)
  )


initialModel : Model
initialModel =
    { numbers = []
    , positions = List.repeat 10 (Position 0 0 0) }


position : Random.Generator Position
position =
  Random.map3 Position (Random.float 0 200) (Random.float 0 100) (Random.int 0 8)


initPositions : Random.Generator Positions
initPositions =
     Random.list 10 position


type Msg
    = Reset
    | Clicked Int
    | Tick Time.Posix
    | RandomPositions Positions


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every 16 Tick


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Reset ->
            (initialModel, Cmd.none )

        Clicked num ->
            ({ model | numbers = model.numbers ++ [num] }, Cmd.none)

        Tick time  ->
            ({ model | positions =
                List.map (\coord -> {coord | x = coord.x + 1, y = coord.y + 1} ) model.positions 
                }, Cmd.none )

        RandomPositions positions ->
            ({ model | positions = positions }, Cmd.none )

view : Model -> Html Msg
view model =
    let
        convertToPX : Float -> String
        convertToPX value = (String.fromInt <| round value) ++ "px"
        
        oneButton : Float -> Float -> Html Msg
        oneButton w h = button [ style "height" "80px", style "width" "80px", style "position" "relative", style "left" (convertToPX w), style "top" (convertToPX h)] []

        buttons = div [] (List.map (\pos -> oneButton pos.x pos.y) model.positions)
    in 
        div []
            [ div [ style "height" "200px", style "width" "800px", style "border-style" "dotted" ] [ buttons ]
                
            ]
