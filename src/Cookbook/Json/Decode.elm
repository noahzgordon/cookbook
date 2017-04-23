module Cookbook.Json.Decode exposing (recipe)

import Json.Decode exposing (..)
import Cookbook.Recipe as Recipe exposing (..)
import Cookbook.Amounts exposing (..)


recipe : Decoder Recipe
recipe =
    let
        decideDecoder t =
            case t of
                "ingredient" ->
                    ingredient

                "step" ->
                    step

                _ ->
                    fail ("invalid type '" ++ t ++ "'")
    in
        field "type" string |> andThen decideDecoder


ingredient : Decoder Recipe
ingredient =
    map2 Recipe.ingredient
        (field "amount" amount)
        (field "name" string)


step : Decoder Recipe
step =
    map3 Recipe.step
        (field "name" string)
        (field "instruction" string)
        (field "subSteps" (list recipe))


amount : Decoder Amount
amount =
    -- temp
    succeed dash
