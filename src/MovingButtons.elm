module MovingButtons exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Random
import Task
import Time
import Array


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Direction =
    { x : Float, y : Float}

type alias Position =
    { x : Float, y : Float, direction : Direction }


type alias Positions =
    List Position


type alias Model =
    { numbers : List Int
    , positions : Positions
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel
    , Random.generate RandomPositions positionsGen
    )


initialModel : Model
initialModel =
    { numbers = []
    , positions = List.repeat 10 (Position 0 0 <| Direction 0 0)
    }

oneOrMinusOneGen : Random.Generator Float
oneOrMinusOneGen =
    Random.int 0 1
      |> Random.andThen (\i -> Random.constant <| Maybe.withDefault 10 <| Array.get i <| Array.fromList [-1, 1])

directionGen : Random.Generator Direction
directionGen =
    Random.map2 Direction oneOrMinusOneGen oneOrMinusOneGen

positionGen : Random.Generator Position
positionGen =
    Random.map3 Position (Random.float 0 (800 - 60)) (Random.float 0 (300 - 60)) directionGen


positionsGen : Random.Generator Positions
positionsGen =
    Random.list 10 positionGen


type Msg
    = Reset
    | Clicked Int
    | Tick Time.Posix
    | RandomPositions Positions


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 16 Tick


changeDirectionButton : Position -> Position
changeDirectionButton pos =
    if pos.x < 0 || pos.x > 800 - 60 then
        { pos | direction = { x = pos.direction.x * -1, y = pos.direction.y } }

    else if pos.y < 0 || pos.y > 300 - 60 then
        { pos | direction = { x = pos.direction.x, y = pos.direction.y  * -1 } }

    else
        pos

moveButton : Position -> Position
moveButton pos =
    { pos | x = pos.x + (pos.direction.x * 2), y = pos.y + (pos.direction.y * 2)}

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Reset ->
            ( initialModel, Cmd.none )

        Clicked num ->
            ( { model | numbers = model.numbers ++ [ num ] }, Cmd.none )

        Tick time ->
            ( { model
                | positions =
                    List.map (\pos -> moveButton <|changeDirectionButton pos ) model.positions
              }
            , Cmd.none
            )

        RandomPositions positions ->
            ( { model | positions = positions }, Cmd.none )


view : Model -> Html Msg
view model =
    let
        px : Float -> String
        px value =
            (String.fromInt <| round value) ++ "px"

        oneButton : Int -> Position -> Html Msg
        oneButton i pos =
            button
                [ style "height" (px 60)
                , style "width" (px 60)
                , style "left" (px pos.x)
                , style "position" "absolute"
                , style "top" (px pos.y)
                , onClick <| Clicked i
                ] [ text <| String.fromInt i ]

        buttons =
            div [style "height" "300px", style "width" "800px", style "border-style" "dotted", style "position" "relative"] (List.indexedMap (\i pos -> oneButton i pos) model.positions)
    in
    div []
        [ div [] [text <| Debug.toString <| model.numbers]
        , div [ ] [ buttons ]
        ]
