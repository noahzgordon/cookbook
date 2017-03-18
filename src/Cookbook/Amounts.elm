module Cookbook.Amounts exposing (..)


type Amount
    = Cups Int Int
    | Fraction Int Int
    | Number Int


toString : Amount -> String
toString amount =
    case amount of
        Cups numerator denominator ->
            if numerator == denominator then
                Basics.toString numerator ++ " cups"
            else
                Basics.toString numerator ++ "/" ++ Basics.toString denominator ++ " cups"

        Fraction numerator denominator ->
            Basics.toString numerator
                ++ "/"
                ++ Basics.toString denominator

        Number int ->
            Basics.toString int
