import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random
import Random.Extra
import Random.Char
import Keyboard exposing (Key(..))
import Time
import Html.Attributes as Attr exposing (..)

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
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model 1 '0' [] ""
  , sendMessage
  )

-- UPDATE


type Msg
  = Roll Time.Posix
  | NewVariables (Int, Char)
  | KeyboardMsg Keyboard.Msg
  | Restart

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll time ->
      ( model
      , sendMessage
      )

    NewVariables (num, char) ->
      ( { model | number = num, charachter = char }
      , Cmd.none
      )
      
    KeyboardMsg keyMsg ->
      (changeIfPressed { model | pressedKeys = Keyboard.update keyMsg model.pressedKeys }
      , Cmd.none
      )
    Restart ->
      ( { model | phoneNumber = ""}
      , Cmd.none
      )

randomPoint : Random.Generator (Int, Char)
randomPoint =
    Random.pair (Random.int 0 9) (Random.Char.char 97 122)

sendMessage: Cmd Msg 
sendMessage =
        Random.generate NewVariables randomPoint
        



changeIfPressed : Model -> Model
changeIfPressed model =
        if List.any ( checkKey model.charachter) model.pressedKeys then
            { model | phoneNumber = model.phoneNumber ++ (String.fromInt model.number) }
            
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
       [ (Sub.map KeyboardMsg Keyboard.subscriptions)
       , (Time.every 5000 Roll) ]


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text <| "Please enter " ++ (String.fromChar model.charachter) ++ " to get " ++ (String.fromInt model.number) ++ " !" ]
    , h1 [] [ text <|"Here is your phone number :  " ++ model.phoneNumber ]
    , button [ onClick Restart ] [ text "Restart" ]
    ]
