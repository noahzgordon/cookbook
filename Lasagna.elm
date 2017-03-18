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
        [ ingredient "1 pound bulk Italian sausage"
        , ingredient "1 pound ground beef"
        , ingredient "1 pound ground beef"
        , ingredient "1 cup chopped onion"
        , ingredient "4 cloves minced garlic"
        ]
        |> inOneOf [ "dutch oven", "heavy pot" ]
        |> stoveCook Medium (MinuteRange 10 15)
        |> withName "meat mixture"


sauceMix : Recipe
sauceMix =
    combine
        [ ingredient "2 (8 ounce) cans tomato sauce"
        , ingredient "1 (14 ounce) can crushed tomatoes"
        , ingredient "1 (14 ounce) can Italian-style crushed tomatoes"
        , ingredient "2 (6 ounce) cans tomato paste"
        , ingredient "3 tablespoons chopped fresh basil"
        , ingredient "2 tablespoons chopped fresh parsley"
        , ingredient "2 teaspoons brown sugar"
        , ingredient "1 teaspoon salt"
        , ingredient "1 teaspoon Italian seasoning"
        , ingredient "1/4 teaspoon ground black pepper"
        , ingredient "1/2 teaspoon fennel seeds"
        , ingredient "1/2 cup grated Parmesan cheese"
        ]
        |> in_ "bowl"
        |> withName "sauce mixture"


combinedMix =
    meatMix
        |> stirIn [ sauceMix ]
        |> withName "sauce"
        |> boil Low (HourRange 1 6)


noodles =
    ingredient "12 lasagna noodles"
        |> soak (Minutes 30) (ingredient "very hot tap water")


eggCheese =
    ingredient "1 egg"
        |> beat
        |> stirIn
            [ ingredient "1 (15 ounce) container ricotta cheese"
            , ingredient "2 tablespoons chopped fresh parsley"
            , ingredient "1/2 teaspoon salt"
            , ingredient "a pinch ground nutmeg"
            ]
        |> withName "egg and cheese mixture"


lasagna =
    layer 3
        "9x13-inch baking dish"
        [ ( combinedMix, Cups 1 1 )
        , ( noodles, Number 4 )
        , ( eggCheese, Fraction 1 4 )
        , ( ingredient "16 ounces shredded mozzarella cheese", Fraction 1 3 )
        , ( ingredient "3/4 cup grated Parmesan cheese", Cups 1 4 )
        ]
        |> withName "lasagna"
        |> coverTop "aluminum foil"
        |> bake (Minutes 50) (Fahrenheit 375)
        |> uncoverTop
        |> bake (MinuteRange 15 20) (Fahrenheit 375)
        |> letSit (Minutes 15)
