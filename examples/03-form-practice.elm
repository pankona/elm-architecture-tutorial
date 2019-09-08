module Main exposing (Model, Msg(..), init, main, update, view, viewInput, viewValidation)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : Int
    , submitted : Bool
    }


init : Model
init =
    Model "" "" "" 0 False


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Age age ->
            { model | age = Maybe.withDefault model.age (String.toInt age) }

        Submit ->
            { model | submitted = True }


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewInput "age" "Age" (String.fromInt model.age) Age
        , button [ onClick Submit ] [ text "Submit" ]
        , viewValidation model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html Msg
viewValidation model =
    if not model.submitted then
        div [ style "color" "black" ] [ text "Please input your name, password and age" ]

    else if model.password == "" then
        div [ style "color" "red" ] [ text "Please input password" ]

    else if String.length model.password < 8 then
        div [ style "color" "red" ] [ text "Password is too short!" ]

    else if not (String.any Char.isDigit model.password) then
        div [ style "color" "red" ] [ text "Password needs to include at least 1 digit" ]

    else if not (String.any Char.isUpper model.password) then
        div [ style "color" "red" ] [ text "Password needs to include at least 1 upper character" ]

    else if not (String.any Char.isLower model.password) then
        div [ style "color" "red" ] [ text "Password needs to include at least 1 lower character" ]

    else if model.password /= model.passwordAgain then
        div [ style "color" "red" ] [ text "Passwords do not match!" ]

    else
        div [ style "color" "green" ] [ text "OK" ]
