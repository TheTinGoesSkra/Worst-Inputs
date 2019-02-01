module Main exposing (main)

import Browser

import Template
import MovingButtons
import Html exposing (Html, div)


type alias Model =
    { template : Template.Model
    , movingButtons : MovingButtons.Model}


initialModel : Model
initialModel =
    { template = Template.initialModel
    , movingButtons = MovingButtons.initialModel }


type Msg
    = Template Template.Msg
    | MovingButtons MovingButtons.Msg



update : Msg -> Model -> Model
update msg model =
    case msg of
        Template template ->
            { model | template = Template.update template model.template }
            
        MovingButtons movingButtons ->
            { model | movingButtons = MovingButtons.update movingButtons model.movingButtons }


view : Model -> Html Msg
view model =
    div []
        [ Html.map Template (Template.view model.template)
        , Html.map MovingButtons (MovingButtons.view model.movingButtons)
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
