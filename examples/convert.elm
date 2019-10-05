module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Attribute, Html, div, input, span, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { celsiusInput : String
    , fahrenheitInput : String
    , inchInput : String
    }


init : Model
init =
    Model "" "" ""



-- UPDATE


type Msg
    = CelsiusChange String
    | FahrenheitChange String
    | InchChange String


update : Msg -> Model -> Model
update msg model =
    case msg of
        CelsiusChange newInput ->
            { model | celsiusInput = newInput }

        FahrenheitChange newInput ->
            { model | fahrenheitInput = newInput }

        InchChange newInput ->
            { model | inchInput = newInput }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ case String.toFloat model.celsiusInput of
            Just celsius ->
                viewCelsiusConverter model.celsiusInput "blue" (String.fromFloat (celsius * 1.8 + 32)) "blue"

            Nothing ->
                viewCelsiusConverter model.celsiusInput "red" "???" "red"
        , case String.toFloat model.fahrenheitInput of
            Just fahrenheit ->
                viewFahrenheitConverter model.fahrenheitInput "blue" (String.fromFloat ((fahrenheit - 32) / 1.8)) "blue"

            Nothing ->
                viewFahrenheitConverter model.fahrenheitInput "red" "???" "red"
        , case String.toFloat model.inchInput of
            Just inch ->
                viewInchConverter model.inchInput "blue" (String.fromFloat (inch * 0.0254)) "blue"

            Nothing ->
                viewInchConverter model.inchInput "red" "???" "red"
        ]


viewCelsiusConverter : String -> String -> String -> String -> Html Msg
viewCelsiusConverter userInput color equivalentTemp borderColor =
    div []
        [ input [ value userInput, onInput CelsiusChange, style "width" "40px", style "border-color" borderColor, style "outline" "0" ] []
        , text "°C = "
        , span [ style "color" color ] [ text equivalentTemp ]
        , text "°F"
        ]


viewFahrenheitConverter : String -> String -> String -> String -> Html Msg
viewFahrenheitConverter userInput color equivalentTemp borderColor =
    div []
        [ input [ value userInput, onInput FahrenheitChange, style "width" "40px", style "border-color" borderColor, style "outline" "0" ] []
        , text "°F = "
        , span [ style "color" color ] [ text equivalentTemp ]
        , text "°C"
        ]


viewInchConverter : String -> String -> String -> String -> Html Msg
viewInchConverter userInput color equivalentTemp borderColor =
    div []
        [ input [ value userInput, onInput InchChange, style "width" "40px", style "border-color" borderColor, style "outline" "0" ] []
        , text "inch = "
        , span [ style "color" color ] [ text equivalentTemp ]
        , text "m"
        ]
