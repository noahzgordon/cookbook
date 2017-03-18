module Cookbook.Temperature exposing (..)


type Temperature
    = Low
    | Medium
    | High
    | Fahrenheit Int
    | Celsius Int


toString : Temperature -> String
toString temp =
    case temp of
        Low ->
            "low"

        Medium ->
            "medium"

        High ->
            "high"

        Fahrenheit int ->
            Basics.toString int ++ " degrees Fahrenheit"

        Celsius int ->
            Basics.toString int ++ " degrees Celsius"
