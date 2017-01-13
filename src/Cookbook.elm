module Cookbook exposing (..)

import Html


type alias Name =
    String


type alias Instruction =
    String


type Recipe
    = PlaceOnTop Recipe Recipe
    | Spread Recipe Recipe
    | Ingredient Name


generateHtml : Recipe -> Html.Html msg
generateHtml recipe =
    instructions recipe
        |> formatInstructions


instructions : Recipe -> List Instruction
instructions recipe =
    case recipe of
        PlaceOnTop top bottom ->
            instructions top
                ++ instructions bottom
                ++ [ "place " ++ name top ++ " on top of " ++ name bottom ]

        Spread spread base ->
            instructions spread
                ++ instructions base
                ++ [ "spread " ++ name spread ++ " onto " ++ name base ]

        Ingredient name ->
            [ "Take " ++ name ]


name : Recipe -> Name
name recipe =
    case recipe of
        PlaceOnTop top bottom ->
            name bottom ++ " with " ++ name top ++ " on top"

        Spread spread base ->
            name base ++ " with " ++ name spread ++ " spread"

        Ingredient name ->
            name


formatInstructions : List Instruction -> Html.Html msg
formatInstructions instructions =
    let
        formatSingle text =
            Html.li [] [ Html.text text ]
    in
        Html.ul []
            (List.map formatSingle instructions)



-- name : Component -> Name
-- name (Component name _ _) =
-- name
-- instruction : Component -> Instruction
-- instruction (Component _ instruction _) =
-- instruction
-- subComponents : Component -> List Component
-- subComponents (Component _ _ subs) =
-- subs
