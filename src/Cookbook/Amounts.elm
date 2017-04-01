module Cookbook.Amounts exposing (..)


type Amount
    = Volume Volume
    | Weight Weight
    | Number Int
    | Fraction Float
    | Pinch
    | Dash
    | Unspecified


type Volume
    = Cups Float
    | Tablespoons Float
    | Teaspoons Float
    | LiquidOunces Float


type Weight
    = Pounds Float
    | Ounces Float


cups =
    Volume << Cups


tablespoons =
    Volume << Tablespoons


teaspoons =
    Volume << Teaspoons


liquidOunces =
    Volume << LiquidOunces


pounds =
    Weight << Pounds


ounces =
    Weight << Ounces


num =
    Number


fraction =
    Fraction


pinch =
    Pinch


dash =
    Dash


unspecified =
    Unspecified


format : Amount -> String -> String
format amount name =
    case amount of
        Volume vol ->
            case vol of
                Cups num ->
                    formatFraction num ++ " cups of " ++ name

                Teaspoons num ->
                    formatFraction num ++ " teaspoons of " ++ name

                Tablespoons num ->
                    formatFraction num ++ " tablespoons of " ++ name

                LiquidOunces num ->
                    formatFraction num ++ " ounces of " ++ name

        Weight weight ->
            case weight of
                Pounds num ->
                    formatFraction num ++ " pounds of " ++ name

                Ounces num ->
                    formatFraction num ++ " ounces of " ++ name

        Number int ->
            Basics.toString int ++ " " ++ name ++ "s"

        Fraction num ->
            formatFraction num ++ " of the " ++ name

        Pinch ->
            "a pinch of " ++ name

        Dash ->
            "a dash of " ++ name

        Unspecified ->
            name


formatFraction : Float -> String
formatFraction num =
    let
        wholes =
            floor num

        remainder =
            num - (toFloat wholes)

        fraction =
            case remainder of
                0.9375 ->
                    Just "15/16"

                0.875 ->
                    Just "7/8"

                0.8125 ->
                    Just "13/16"

                0.75 ->
                    Just "3/4"

                0.6875 ->
                    Just "11/16"

                0.625 ->
                    Just "5/8"

                0.5625 ->
                    Just "9/16"

                0.5 ->
                    Just "1/2"

                0.4375 ->
                    Just "7/16"

                0.375 ->
                    Just "3/8"

                0.3125 ->
                    Just "5/16"

                0.25 ->
                    Just "1/4"

                0.1875 ->
                    Just "3/16"

                0.125 ->
                    Just "1/8"

                0.0625 ->
                    Just "1/16"

                0 ->
                    Nothing

                _ ->
                    Just (toString num)
    in
        if wholes > 0 then
            case fraction of
                Just f ->
                    toString wholes ++ " " ++ f

                Nothing ->
                    toString wholes
        else
            case fraction of
                Just f ->
                    f

                Nothing ->
                    "zero"
