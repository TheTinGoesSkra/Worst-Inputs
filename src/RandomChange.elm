module RandomChange exposing (Model, Msg(..), changeIfPressed, checkKey, init, initCmd, initModel, main, randomPoint, sendMessage, subscriptions, update, updateCmd, updateModel, view)

import Browser
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Keyboard exposing (Key(..))
import Random
import Random.Char
import Random.Extra
import Time



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { number : Int
    , charachter : Char
    , pressedKeys : List Key
    , phoneNumber : String
    , message : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , initCmd
    )


initCmd : Cmd Msg
initCmd =
    sendMessage


initModel : Model
initModel =
    Model 1 '0' [] "" ""



-- UPDATE


type Msg
    = Roll Time.Posix
    | NewVariables ( Int, Char )
    | KeyboardMsg Keyboard.Msg
    | Restart
    | Submit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateModel msg model, updateCmd msg model )


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        Roll time ->
            model

        NewVariables ( num, char ) ->
            { model | number = num, charachter = char }

        KeyboardMsg keyMsg ->
            changeIfPressed { model | pressedKeys = Keyboard.update keyMsg model.pressedKeys }

        Restart ->
            { model | phoneNumber = "" }

        Submit ->
            { model | message = "Took you long enough" }


updateCmd : Msg -> Model -> Cmd Msg
updateCmd msg model =
    case msg of
        Roll time ->
            sendMessage

        NewVariables ( num, char ) ->
            Cmd.none

        KeyboardMsg keyMsg ->
            Cmd.none

        Restart ->
            Cmd.none

        Submit ->
            Cmd.none


randomPoint : Random.Generator ( Int, Char )
randomPoint =
    Random.pair (Random.int 0 9) (Random.Char.char 97 122)


sendMessage : Cmd Msg
sendMessage =
    Random.generate NewVariables randomPoint


changeIfPressed : Model -> Model
changeIfPressed model =
    if List.any (checkKey model.charachter) model.pressedKeys && String.length model.phoneNumber < 10 then
        { model | phoneNumber = model.phoneNumber ++ String.fromInt model.number }

    else
        model


checkKey : Char -> Keyboard.Key -> Bool
checkKey char key =
    case key of
        Character keyString ->
            (String.fromChar <| Char.toUpper char) == keyString

        _ ->
            False



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map KeyboardMsg Keyboard.subscriptions
        , Time.every 1000 Roll
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text " Tip o' the morning to ya!" ]
        , h1 [] [ text <| "Please enter " ++ String.fromChar model.charachter ++ " to get " ++ String.fromInt model.number ]
        , h1 [] [ text <| "Here is your phone number :  " ++ model.phoneNumber ]
        , button [ onClick Restart ] [ text "Let's try again, that shit's too hard" ]
        , button [ onClick Submit ] [ text "gottim!" ]
        ]
