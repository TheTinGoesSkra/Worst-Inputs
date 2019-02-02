module MovingButtons exposing (..)

import Array
import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Random
import Task
import Time
import Bootstrap.Button as Button
import Bootstrap.Utilities.Spacing as Spacing

main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Direction =
    { x : Float, y : Float }


type alias Position =
    { x : Float, y : Float, direction : Direction, speed : Float }


type alias Positions =
    List Position


type alias Alert =
    { message : String, color : String }


type alias Model =
    { numbers : List Int
    , positions : Positions
    , alert : Alert
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , initCmd
    )


initCmd : Cmd Msg
initCmd =
    Random.generate RandomPositions positionsGen


initModel : Model
initModel =
    { numbers = []
    , positions = List.repeat 10 (Position 0 0 (Direction 0 0) 0)
    , alert = Alert "" ""
    }


oneOrMinusOneGen : Random.Generator Float
oneOrMinusOneGen =
    Random.int 0 1
        |> Random.andThen (\i -> Random.constant <| Maybe.withDefault 1 <| Array.get i <| Array.fromList [ -1, 1 ])


directionGen : Random.Generator Direction
directionGen =
    Random.map2 Direction oneOrMinusOneGen oneOrMinusOneGen


positionGen : Random.Generator Position
positionGen =
    Random.map4 Position (Random.float 0 (800 - 60)) (Random.float 0 (300 - 60)) directionGen (Random.float 2 4)


positionsGen : Random.Generator Positions
positionsGen =
    Random.list 10 positionGen


type Msg
    = Reset
    | Clicked Int
    | Tick Time.Posix
    | RandomPositions Positions
    | ChangeAlert


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 16 Tick


changeDirectionX : Position -> Position
changeDirectionX pos =
    { pos | direction = { x = pos.direction.x * -1, y = pos.direction.y } }


changeDirectionY : Position -> Position
changeDirectionY pos =
    { pos | direction = { x = pos.direction.x, y = pos.direction.y * -1 } }


changeDirection : Position -> Position
changeDirection pos =
    if (pos.x < 0 || pos.x > 800 - 60) && (pos.y < 0 || pos.y > 300 - 60) then
        changeDirectionY <| changeDirectionX pos

    else if pos.x < 0 || pos.x > 800 - 60 then
        changeDirectionX pos

    else if pos.y < 0 || pos.y > 300 - 60 then
        changeDirectionY pos

    else
        pos


move : Position -> Position
move pos =
    { pos | x = pos.x + (pos.direction.x * pos.speed), y = pos.y + (pos.direction.y * pos.speed) }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateModel msg model, updateCmd msg model )


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        Reset ->
            { model | numbers = [], alert = Alert "" "" }

        Clicked num ->
            if List.length model.numbers < 10 then
                { model | numbers = model.numbers ++ [ num ] }

            else
                model

        Tick time ->
            { model
                | positions =
                    List.map (\pos -> move <| changeDirection pos) model.positions
            }

        RandomPositions positions ->
            { model | positions = positions }

        ChangeAlert ->
            if List.length model.numbers < 10 then
                { model | alert = Alert "Please enter a 10 digit number" "red" }

            else
                { model | alert = Alert "Thank you" "green" }


updateCmd : Msg -> Model -> Cmd Msg
updateCmd msg model =
    Cmd.none


view : Model -> Html Msg
view model =
    let
        px : Float -> String
        px value =
            (String.fromInt <| round value) ++ "px"

        oneButton : Int -> Position -> Html Msg
        oneButton i pos =
            Button.button 
                [ Button.secondary
                , Button.attrs 
                    [style "height" (px 60)
                    , style "width" (px 60)
                    , style "left" (px pos.x)
                    , style "position" "absolute"
                    , style "top" (px pos.y)
                    , onClick <| Clicked i ]
                    ]
                [ text <| String.fromInt i ]

        buttons =
            div
                [ style "height" "300px"
                , style "width" "800px"
                , style "border-style" "solid"
                , style "position" "relative"
                ]
                (List.indexedMap oneButton model.positions)
    in
    div []
        [ h4 [ style "height" "1em", Spacing.mb1 ] [ text <| "Phone number: " ++ List.foldl (\i b -> b ++ String.fromInt i)  ""  model.numbers ]
        , Button.button [ Button.danger, Button.attrs [ onClick Reset ] ] [ text "Reset" ]
        , Button.button [ Button.primary, Button.attrs [ onClick ChangeAlert, Spacing.m2 ] ] [ text "Submit" ]
        , h6 [ style "color" model.alert.color, style "display" "inline-block" ] [ text model.alert.message ]
        , div [] [ buttons ]
        ]
