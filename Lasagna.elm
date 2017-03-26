module Lasagna exposing (main)

import Cookbook exposing (..)
import Cookbook.Recipe exposing (..)
import Cookbook.Duration as Duration exposing (..)
import Cookbook.Temperature as Temperature exposing (..)
import Cookbook.Amounts exposing (..)


{- "Kim's Lasagna"
   credit: http://allrecipes.com/recipe/232337/kims-lasagna/
-}


main =
    Cookbook.generateHtml lasagna


meatMix : Recipe
meatMix =
    combine
        [ ingredient (Weight (Pounds 1 1)) "bulk Italian sausage"
        , ingredient (Weight (Pounds 1 1)) "ground beef"
        , ingredient (Weight (Pounds 1 1)) "ground beef"
        , ingredient (Volume (Cups 1 1)) "chopped onion"
        , ingredient (Number 4) "cloves minced garlic"
        ]
        |> inOneOf [ "dutch oven", "heavy pot" ]
        |> stoveCook Medium (MinuteRange 10 15)
        |> withName "meat mixture"


sauceMix : Recipe
sauceMix =
    combine
        [ ingredient (Volume (LiquidOunces 16 1)) "tomato sauce"
        , ingredient (Volume (LiquidOunces 14 1)) "crushed tomatoes"
        , ingredient (Volume (LiquidOunces 14 1)) "Italian-style crushed tomatoes"
        , ingredient (Volume (LiquidOunces 12 1)) "tomato paste"
        , ingredient (Volume (Tablespoons 3 1)) "chopped fresh basil"
        , ingredient (Volume (Tablespoons 2 1)) "chopped fresh parsley"
        , ingredient (Volume (Teaspoons 2 1)) "brown sugar"
        , ingredient (Volume (Teaspoons 1 1)) "salt"
        , ingredient (Volume (Teaspoons 1 1)) "Italian seasoning"
        , ingredient (Volume (Teaspoons 1 4)) "ground black pepper"
        , ingredient (Volume (Teaspoons 1 2)) "fennel seeds"
        , ingredient (Volume (Cups 1 2)) "grated Parmesan cheese"
        ]
        |> in_ "bowl"
        |> withName "sauce mixture"


combinedMix =
    meatMix
        |> stirIn [ sauceMix ]
        |> withName "sauce"
        |> boil Low (HourRange 1 6)


noodles =
    ingredient (Number 12) "lasagna noodles"
        |> soak (Minutes 30) (ingredient Unspecified "very hot tap water")


eggCheese =
    ingredient (Number 1) "egg"
        |> beat
        |> stirIn
            [ ingredient (Weight (Ounces 15 1)) "ricotta cheese"
            , ingredient (Volume (Tablespoons 2 1)) "chopped fresh parsley"
            , ingredient (Volume (Teaspoons 1 2)) "salt"
            , ingredient Pinch "ground nutmeg"
            ]
        |> withName "egg and cheese mixture"


lasagna =
    layer 3
        "9x13-inch baking dish"
        [ ( combinedMix, Volume (Cups 1 1) )
        , ( noodles, Number 4 )
        , ( eggCheese, Fraction 1 4 )
        , ( ingredient (Weight (Ounces 16 1)) "shredded mozzarella cheese", Fraction 1 3 )
        , ( ingredient (Volume (Cups 3 4)) "grated Parmesan cheese", Volume (Cups 1 4) )
        ]
        |> withName "lasagna"
        |> coverTop "aluminum foil"
        |> bake (Minutes 50) (Fahrenheit 375)
        |> uncoverTop
        |> bake (MinuteRange 15 20) (Fahrenheit 375)
        |> letSit (Minutes 15)
