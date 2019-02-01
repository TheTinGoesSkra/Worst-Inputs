module Main exposing (main)

import Browser

import Template
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


type alias Model =
    { template : Template.Model }


initialModel : Model
initialModel =
    { template = Template.initialModel }


type Msg
    = Template Template.Msg



update : Msg -> Model -> Model
update msg model =
    case msg of
        Template template ->
            { model | template = Template.update template model.template }


view : Model -> Html Msg
view model =

    div []
        [ Template.view model.template
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
