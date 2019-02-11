module Main exposing (main)

import Browser
import MovingButtons
import Template
import AutoIncrement
import RandomNumber
import NumIncrement

import Html exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid


type alias Model =
    { template : Template.Model
    , movingButtons : MovingButtons.Model
    , randomNumber : RandomNumber.Model
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , initCmd
    )


initCmd : Cmd Msg
initCmd =
    Cmd.batch
        [ Cmd.map Template Template.initCmd
        , Cmd.map MovingButtons MovingButtons.initCmd
        , Cmd.map RandomNumber RandomNumber.initCmd
        ]


initModel : Model
initModel =
    { template = Template.initModel
    , movingButtons = MovingButtons.initModel
    , randomNumber = RandomNumber.initModel
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map Template (Template.subscriptions model.template)
        , Sub.map MovingButtons (MovingButtons.subscriptions model.movingButtons)
        , Sub.map RandomNumber (RandomNumber.subscriptions model.randomNumber)
        ]


type Msg
    = Template Template.Msg
    | MovingButtons MovingButtons.Msg
    | RandomNumber RandomNumber.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateModel msg model, updateCmd msg model )


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        Template template ->
            { model | template = Template.updateModel template model.template }

        MovingButtons movingButtons ->
            { model | movingButtons = MovingButtons.updateModel movingButtons model.movingButtons }

        RandomNumber randomNumber ->
            { model | randomNumber = RandomNumber.updateModel randomNumber model.randomNumber }




updateCmd : Msg -> Model -> Cmd Msg
updateCmd msg model =
    case msg of
        Template template ->
            Cmd.map Template <| Template.updateCmd template model.template

        MovingButtons movingButtons ->
            Cmd.map MovingButtons <| MovingButtons.updateCmd movingButtons model.movingButtons

        RandomNumber randomNumber ->
            Cmd.map RandomNumber <| RandomNumber.updateCmd randomNumber model.randomNumber


view : Model -> Html Msg
view model =
    Grid.container []
        [ CDN.stylesheet 
        , Html.map Template (Template.view model.template)
        , hr [] []
        , Html.map MovingButtons (MovingButtons.view model.movingButtons)
        , hr [] []
        , Html.map RandomNumber (RandomNumber.view model.randomNumber)
        ]


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
