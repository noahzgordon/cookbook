module Cookbook.Json.Decode exposing (recipe)

import Json.Decode exposing (..)
import Cookbook.Recipe as Recipe
import Cookbook.Amounts as Amounts


recipe : Decoder Recipe.Recipe
recipe =
    field "type" string
        |> andThen
            (\t ->
                case t of
                    "ingredient" ->
                        ingredient

                    "step" ->
                        step

                    _ ->
                        fail ("Invalid top-level type '" ++ t ++ "' provided")
            )


ingredient : Decoder Recipe.Recipe
ingredient =
    map2 Recipe.ingredient
        (field "amount" amount)
        (field "name" string)


step : Decoder Recipe.Recipe
step =
    map3 Recipe.step
        (field "name" string)
        (field "instruction" string)
        (field "subSteps" (list recipe))


amount : Decoder Amounts.Amount
amount =
    field "measurement" string
        |> andThen
            (\m ->
                case m of
                    "cups" ->
                        map Amounts.cups (field "amount" float)

                    "tbsp" ->
                        map Amounts.tablespoons (field "amount" float)

                    "tsp" ->
                        map Amounts.teaspoons (field "amount" float)

                    "lqoz" ->
                        map Amounts.liquidOunces (field "amount" float)

                    "lbs" ->
                        map Amounts.pounds (field "amount" float)

                    "oz" ->
                        map Amounts.ounces (field "amount" float)

                    "number" ->
                        map Amounts.num (field "amount" int)

                    "fraction" ->
                        map Amounts.fraction (field "amount" float)

                    "pinch" ->
                        succeed Amounts.pinch

                    "dash" ->
                        succeed Amounts.dash

                    "unspecified" ->
                        succeed Amounts.unspecified

                    _ ->
                        fail ("Invalid measurement '" ++ m ++ "' provided")
            )
