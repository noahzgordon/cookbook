module Cookbook exposing (..)

import Html


type alias Name =
    String


type alias Instruction =
    String


type Component
    = Component Name Instruction (List Component)


generateHtml : Component -> Html.Html msg
generateHtml component =
    (subComponents component)
        ++ [ component ]
        |> List.map instruction
        |> formatInstructions


formatInstructions : List Instruction -> Html.Html msg
formatInstructions instructions =
    let
        formatSingle text =
            Html.li [] [ Html.text text ]
    in
        Html.ul []
            (List.map formatSingle instructions)


name : Component -> Name
name (Component name _ _) =
    name


instruction : Component -> Instruction
instruction (Component _ instruction _) =
    instruction


subComponents : Component -> List Component
subComponents (Component _ _ subs) =
    subs
