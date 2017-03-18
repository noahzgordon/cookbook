module Cookbook.Recipe exposing (..)


type Recipe
    = Ingredient { name : String }
    | Step { name : String, instruction : String, subSteps : List Recipe }


type Cookware
    = Cookware String
    | CookwareChoice (List String)


ingredient : String -> Recipe
ingredient name =
    Ingredient { name = name }


name : Recipe -> String
name recipe =
    case recipe of
        Ingredient { name } ->
            name

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


instructions : Recipe -> List String
instructions recipe =
    case recipe of
        Step step ->
            (List.concatMap instructions step.subSteps) ++ [ step.instruction ]

        Ingredient ingredient ->
            [ "Take " ++ ingredient.name ++ "." ]
