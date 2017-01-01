module Cookbook.Techniques exposing (..)

import Cookbook
    exposing
        ( name
        , instruction
        , Name
        , Instruction
        , Component(..)
        )


placeOnTop : Component -> Component -> Component
placeOnTop top bottom =
    let
        instruction =
            "Place " ++ (name top) ++ " on top of " ++ (name bottom) ++ "."

        newName =
            (name bottom) ++ " with " ++ (name top) ++ " on top"
    in
        combineComponents newName instruction top bottom


spread : Component -> Component -> Component
spread spread base =
    let
        instruction =
            "Spread " ++ (name spread) ++ " onto " ++ (name base) ++ "."

        newName =
            (name base) ++ " with " ++ (name spread) ++ " spread"
    in
        combineComponents newName instruction spread base


combineComponents : Name -> Instruction -> Component -> Component -> Component
combineComponents newName newInstruction comp1 comp2 =
    let
        (Component _ _ subComponents1) =
            comp1

        (Component _ _ subComponents2) =
            comp2
    in
        Component newName newInstruction (subComponents1 ++ [ comp1 ] ++ subComponents2 ++ [ comp2 ])
