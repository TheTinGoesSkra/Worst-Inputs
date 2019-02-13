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
    , autoIncrement : AutoIncrement.Model
    , numIncrement : NumIncrement.Model
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
        , Cmd.map AutoIncrement AutoIncrement.initCmd
        , Cmd.map NumIncrement NumIncrement.initCmd
        ]


initModel : Model
initModel =
    { template = Template.initModel
    , movingButtons = MovingButtons.initModel
    , randomNumber = RandomNumber.initModel
    , autoIncrement = AutoIncrement.initModel
    , numIncrement = NumIncrement.initModel
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map Template (Template.subscriptions model.template)
        , Sub.map MovingButtons (MovingButtons.subscriptions model.movingButtons)
        , Sub.map RandomNumber (RandomNumber.subscriptions model.randomNumber)
        , Sub.map AutoIncrement (AutoIncrement.subscriptions model.autoIncrement)
        , Sub.map NumIncrement (NumIncrement.subscriptions model.numIncrement)
        ]


type Msg
    = Template Template.Msg
    | MovingButtons MovingButtons.Msg
    | RandomNumber RandomNumber.Msg
    | AutoIncrement AutoIncrement.Msg
    | NumIncrement NumIncrement.Msg


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

        AutoIncrement autoIncrement ->
            { model | autoIncrement = AutoIncrement.updateModel autoIncrement model.autoIncrement }

        NumIncrement numIncrement ->
            { model | numIncrement = NumIncrement.updateModel numIncrement model.numIncrement }




updateCmd : Msg -> Model -> Cmd Msg
updateCmd msg model =
    case msg of
        Template template ->
            Cmd.map Template <| Template.updateCmd template model.template

        MovingButtons movingButtons ->
            Cmd.map MovingButtons <| MovingButtons.updateCmd movingButtons model.movingButtons

        RandomNumber randomNumber ->
            Cmd.map RandomNumber <| RandomNumber.updateCmd randomNumber model.randomNumber

        AutoIncrement autoIncrement ->
            Cmd.map AutoIncrement <| AutoIncrement.updateCmd autoIncrement model.autoIncrement

        NumIncrement numIncrement ->
            Cmd.map NumIncrement <| NumIncrement.updateCmd numIncrement model.numIncrement


view : Model -> Html Msg
view model =
    Grid.container []
        [ CDN.stylesheet 
        , hr [] []
        , Html.map MovingButtons (MovingButtons.view model.movingButtons)
        , hr [] []
        , Html.map RandomNumber (RandomNumber.view model.randomNumber)
        , hr [] []
        , Html.map AutoIncrement (AutoIncrement.view model.autoIncrement)
        , hr [] []
        , Html.map NumIncrement (NumIncrement.view model.numIncrement)
        ]


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
