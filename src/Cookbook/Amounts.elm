module Cookbook.Amounts exposing (..)


type Amount
    = Volume Volume
    | Weight Weight
    | Number Int
    | Fraction Int Int
    | Pinch
    | Dash
    | Unspecified


type Volume
    = Cups Int Int
    | Tablespoons Int Int
    | Teaspoons Int Int
    | LiquidOunces Int Int


type Weight
    = Pounds Int Int
    | Ounces Int Int


format : Amount -> String -> String
format amount name =
    case amount of
        Volume vol ->
            case vol of
                Cups n d ->
                    formatFraction n d ++ " cups of " ++ name

                Teaspoons n d ->
                    formatFraction n d ++ " teaspoons of " ++ name

                Tablespoons n d ->
                    formatFraction n d ++ " tablespoons of " ++ name

                LiquidOunces n d ->
                    formatFraction n d ++ " ounces of " ++ name

        Weight weight ->
            case weight of
                Pounds n d ->
                    formatFraction n d ++ " pounds of " ++ name

                Ounces n d ->
                    formatFraction n d ++ " ounces of " ++ name

        Number int ->
            Basics.toString int ++ " " ++ name ++ "s"

        Fraction n d ->
            formatFraction n d ++ " of the " ++ name

        Pinch ->
            "a pinch of " ++ name

        Dash ->
            "a dash of " ++ name

        Unspecified ->
            name


formatFraction : Int -> Int -> String
formatFraction numerator denominator =
    if denominator == 1 then
        Basics.toString numerator
    else if numerator == denominator then
        "1"
    else
        Basics.toString numerator ++ "/" ++ Basics.toString denominator
