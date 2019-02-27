module Main exposing (main)

import AutoIncrement
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Browser
import Droplist
import Html exposing (..)
import Html.Attributes exposing (style, class)
import MovingButtons
import NumIncrement
import PrimeNumbers
import RandomChange
import RandomNumber
import Template


type alias Model =
    { template : Template.Model
    , movingButtons : MovingButtons.Model
    , randomNumber : RandomNumber.Model
    , autoIncrement : AutoIncrement.Model
    , numIncrement : NumIncrement.Model
    , droplist : Droplist.Model
    , primeNumbers : PrimeNumbers.Model
    , randomChange : RandomChange.Model
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
        , Cmd.map Droplist Droplist.initCmd
        , Cmd.map PrimeNumbers PrimeNumbers.initCmd
        , Cmd.map RandomChange RandomChange.initCmd
        ]


initModel : Model
initModel =
    { template = Template.initModel
    , movingButtons = MovingButtons.initModel
    , randomNumber = RandomNumber.initModel
    , autoIncrement = AutoIncrement.initModel
    , numIncrement = NumIncrement.initModel
    , droplist = Droplist.initModel
    , primeNumbers = PrimeNumbers.initModel
    , randomChange = RandomChange.initModel
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map Template (Template.subscriptions model.template)
        , Sub.map MovingButtons (MovingButtons.subscriptions model.movingButtons)
        , Sub.map RandomNumber (RandomNumber.subscriptions model.randomNumber)
        , Sub.map AutoIncrement (AutoIncrement.subscriptions model.autoIncrement)
        , Sub.map NumIncrement (NumIncrement.subscriptions model.numIncrement)
        , Sub.map Droplist (Droplist.subscriptions model.droplist)
        , Sub.map PrimeNumbers (PrimeNumbers.subscriptions model.primeNumbers)
        , Sub.map RandomChange (RandomChange.subscriptions model.randomChange)
        ]


type Msg
    = Template Template.Msg
    | MovingButtons MovingButtons.Msg
    | RandomNumber RandomNumber.Msg
    | AutoIncrement AutoIncrement.Msg
    | NumIncrement NumIncrement.Msg
    | Droplist Droplist.Msg
    | PrimeNumbers PrimeNumbers.Msg
    | RandomChange RandomChange.Msg


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

        Droplist droplist ->
            { model | droplist = Droplist.updateModel droplist model.droplist }

        PrimeNumbers primeNumbers ->
            { model | primeNumbers = PrimeNumbers.updateModel primeNumbers model.primeNumbers }

        RandomChange randomChange ->
            { model | randomChange = RandomChange.updateModel randomChange model.randomChange }


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

        Droplist droplist ->
            Cmd.map Droplist <| Droplist.updateCmd droplist model.droplist

        PrimeNumbers primeNumbers ->
            Cmd.map PrimeNumbers <| PrimeNumbers.updateCmd primeNumbers model.primeNumbers

        RandomChange randomChange ->
            Cmd.map RandomChange <| RandomChange.updateCmd randomChange model.randomChange


view : Model -> Html Msg
view model =
    Grid.container []
        [ CDN.stylesheet --remove when compiling with elm make
        , div [ class "display-1" ] [ text "Worst Inputs" ]
        , h3 [ style "margin-top" "30px" ] [ text "Would you please be kind enough to enter your phone number in all forms below, thank you" ]
        , hr [] []
        , Html.map MovingButtons (MovingButtons.view model.movingButtons)
        , hr [] []
        , Html.map RandomNumber (RandomNumber.view model.randomNumber)
        , hr [] []
        , Html.map AutoIncrement (AutoIncrement.view model.autoIncrement)
        , hr [] []
        , Html.map NumIncrement (NumIncrement.view model.numIncrement)
        , hr [] []
        , Html.map Droplist (Droplist.view model.droplist)
        , hr [] []
        , Html.map PrimeNumbers (PrimeNumbers.view model.primeNumbers)
        , hr [] []
        , Html.map RandomChange (RandomChange.view model.randomChange)
        , div [ style "margin-bottom" "100px" ] []
        ]


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
