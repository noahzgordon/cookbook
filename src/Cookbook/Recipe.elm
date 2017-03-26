module Cookbook.Recipe exposing (..)
import Cookbook.Amounts as Amounts exposing (..)


type Recipe
    = Ingredient { name : String, amount : Amount }
    | Step { name : String, instruction : String, subSteps : List Recipe }


type Cookware
    = Cookware String
    | CookwareChoice (List String)


ingredient : Amount -> String -> Recipe
ingredient amount name =
    Ingredient { name = name, amount = amount }


name : Recipe -> String
name recipe =
    case recipe of
        Ingredient { name } ->
            name

        Step { name } ->
            name


nameAndAmount : Recipe -> String
nameAndAmount recipe =
    case recipe of
        Ingredient { name, amount } ->
            Amounts.format amount name

        Step { name } ->
            name


setName : String -> Recipe -> Recipe
setName newName recipe =
    case recipe of
        Ingredient i ->
            Ingredient { i | name = newName }

        Step s ->
            Step { s | name = newName }


subSteps : Recipe -> List Recipe
subSteps recipe =
    case recipe of
        Ingredient _ ->
            []

        Step step ->
            step.subSteps


baseIngredients : Recipe -> List Recipe
baseIngredients recipe =
    case recipe of
        Ingredient _ ->
            [ recipe ]

        Step { subSteps } ->
            List.concatMap baseIngredients subSteps


instructions : Recipe -> List String
instructions recipe =
    case recipe of
        Step step ->
            (List.concatMap instructions step.subSteps) ++ [ step.instruction ]

        Ingredient ingredient ->
            []
