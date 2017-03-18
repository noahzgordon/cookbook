module Cookbook.Duration exposing (..)


type Duration
    = Minutes Int
    | MinuteRange Int Int
    | Hours Int
    | HourRange Int Int


toString : Duration -> String
toString duration =
    case duration of
        Minutes int ->
            Basics.toString int ++ " minutes"

        Hours int ->
            Basics.toString int ++ " hours"

        MinuteRange start end ->
            "between "
                ++ Basics.toString start
                ++ " minutes and "
                ++ Basics.toString end
                ++ " minutes"

        HourRange start end ->
            "between "
                ++ Basics.toString start
                ++ " hours and "
                ++ Basics.toString end
                ++ " hours"
