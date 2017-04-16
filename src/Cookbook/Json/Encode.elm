module Cookbook.Json.Encode exposing (recipe)

import Json.Encode exposing (..)
import Cookbook.Recipe exposing (..)
import Cookbook.Amounts exposing (..)


recipe : Recipe -> Value
recipe r =
    case r of
        Ingredient i ->
            object
                [ ( "type", string "ingredient" )
                , ( "name", string i.name )
                , ( "amount", amount i.amount )
                ]

        Step s ->
            object
                [ ( "type", string "step" )
                , ( "name", string s.name )
                , ( "instruction", string s.instruction )
                , ( "subSteps", list <| List.map recipe s.subSteps )
                ]


amount : Amount -> Value
amount a =
    case a of
        Volume v ->
            let
                ( measurement, amount ) =
                    case v of
                        Cups f ->
                            ( "cups", f )

                        Tablespoons f ->
                            ( "tbsp", f )

                        Teaspoons f ->
                            ( "tsp", f )

                        LiquidOunces f ->
                            ( "lqoz", f )
            in
                object
                    [ ( "type", string "amount" )
                    , ( "measurement", string measurement )
                    , ( "amount", float amount )
                    ]

        Weight w ->
            let
                ( measurement, amount ) =
                    case w of
                        Pounds f ->
                            ( "lbs", f )

                        Ounces f ->
                            ( "oz", f )
            in
                object
                    [ ( "type", string "amount" )
                    , ( "measurement", string measurement )
                    , ( "amount", float amount )
                    ]

        Number n ->
            object
                [ ( "type", string "amount" )
                , ( "measurement", string "number" )
                , ( "amount", int n )
                ]

        Fraction f ->
            object
                [ ( "type", string "amount" )
                , ( "measurement", string "fraction" )
                , ( "amount", float f )
                ]

        Pinch ->
            object
                [ ( "type", string "amount" )
                , ( "measurement", string "pinch" )
                ]

        Dash ->
            object
                [ ( "type", string "amount" )
                , ( "measurement", string "dash" )
                ]

        Unspecified ->
            object
                [ ( "type", string "amount" )
                , ( "measurement", string "unspecified" )
                ]
