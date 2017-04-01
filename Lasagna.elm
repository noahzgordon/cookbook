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
        [ ingredient (pounds 1) "bulk Italian sausage"
        , ingredient (pounds 1) "ground beef"
        , ingredient (pounds 1) "ground beef"
        , ingredient (cups 1) "chopped onion"
        , ingredient (num 4) "cloves minced garlic"
        ]
        |> inOneOf [ "dutch oven", "heavy pot" ]
        |> stoveCook Medium (MinuteRange 10 15)
        |> withName "meat mixture"


sauceMix : Recipe
sauceMix =
    combine
        [ ingredient (liquidOunces 16) "tomato sauce"
        , ingredient (liquidOunces 14) "crushed tomatoes"
        , ingredient (liquidOunces 14) "Italian-style crushed tomatoes"
        , ingredient (liquidOunces 12) "tomato paste"
        , ingredient (tablespoons 3) "chopped fresh basil"
        , ingredient (tablespoons 2) "chopped fresh parsley"
        , ingredient (teaspoons 2) "brown sugar"
        , ingredient (teaspoons 1) "salt"
        , ingredient (teaspoons 1) "Italian seasoning"
        , ingredient (teaspoons (1 / 4)) "ground black pepper"
        , ingredient (teaspoons (1 / 2)) "fennel seeds"
        , ingredient (cups (1 / 2)) "grated Parmesan cheese"
        ]
        |> in_ "bowl"
        |> withName "sauce mixture"


combinedMix =
    meatMix
        |> stirIn [ sauceMix ]
        |> withName "sauce"
        |> boil Low (HourRange 1 6)


noodles =
    ingredient (num 12) "lasagna noodles"
        |> soak (Minutes 30) (ingredient unspecified "very hot tap water")


eggCheese =
    ingredient (num 1) "egg"
        |> beat
        |> stirIn
            [ ingredient (ounces 15) "ricotta cheese"
            , ingredient (tablespoons 2) "chopped fresh parsley"
            , ingredient (teaspoons (1 / 2)) "salt"
            , ingredient pinch "ground nutmeg"
            ]
        |> withName "egg and cheese mixture"


lasagna =
    layer 3
        "9x13-inch baking dish"
        [ ( combinedMix, cups 1 )
        , ( noodles, num 4 )
        , ( eggCheese, fraction (1 / 4) )
        , ( ingredient (ounces 16) "shredded mozzarella cheese", fraction (1 / 3) )
        , ( ingredient (cups (3 / 4)) "grated Parmesan cheese", cups (1 / 4) )
        ]
        |> withName "lasagna"
        |> coverTop "aluminum foil"
        |> bake (Minutes 50) (Fahrenheit 375)
        |> uncoverTop
        |> bake (MinuteRange 15 20) (Fahrenheit 375)
        |> letSit (Minutes 15)
