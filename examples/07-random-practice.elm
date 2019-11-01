module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random



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
    { dieFace : Int
    , dieFace2 : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1 1
    , Random.generate NewFace spin
    )



-- UPDATE


type Msg
    = Roll
    | NewFace Model



--dieFaceGenerator : Random.Generator Int
-- dieFaceGenerator =
--     Random.int 1 6


spin : Random.Generator Model
spin =
    Random.map2 Model (Random.int 1 6) (Random.int 1 6)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace spin
            )

        NewFace model2 ->
            ( model2
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (String.fromInt model.dieFace) ]
        , h1 [] [ text (String.fromInt model.dieFace2) ]
        , button [ onClick Roll ] [ text "Roll" ]
        ]
