module Cookbook exposing (..)

import Debug
import Html
import String.Extra as String
import List.Extra as List
import Cookbook.Recipe exposing (..)
import Cookbook.Temperature as Temp exposing (Temperature)
import Cookbook.Duration as Dur exposing (Duration)
import Cookbook.Amounts as Amounts exposing (..)


generateHtml : Recipe -> Html.Html msg
generateHtml recipe =
    Html.div []
        [ Html.section []
            [ Html.h2 [] [ Html.text "Ingredients" ]
            , formatIngredients (baseIngredients recipe)
            ]
        , Html.section []
            [ Html.h2 [] [ Html.text "Instructions" ]
            , instructions recipe
                |> formatInstructions
            ]
        ]


formatIngredients : List Recipe -> Html.Html msg
formatIngredients ingredients =
    let
        formatSingle text =
            Html.li [] [ Html.text text ]
    in
        Html.ul []
            (ingredients
                |> List.map name
                |> List.map formatSingle
            )


formatInstructions : List String -> Html.Html msg
formatInstructions instructions =
    let
        formatSingle text =
            Html.li [] [ Html.text text ]
    in
        Html.ul []
            (List.map formatSingle instructions)


withName : String -> Recipe -> Recipe
withName =
    setName



-- COOKWARE


in_ : String -> Recipe -> Recipe
in_ _ recipe =
    recipe


inOneOf : List String -> Recipe -> Recipe
inOneOf _ recipe =
    recipe



-- TECHNIQUES


combine : List Recipe -> Recipe
combine recipes =
    Step
        { name = "mixture"
        , instruction =
            "combine "
                ++ (List.map name recipes
                        |> String.toSentence
                   )
        , subSteps = recipes
        }


stoveCook : Temperature -> Duration -> Recipe -> Recipe
stoveCook temp duration recipe =
    Step
        { name = "cooked " ++ name recipe
        , instruction = "cook " ++ name recipe ++ " on a stove"
        , subSteps = [ recipe ]
        }


stirIn : List Recipe -> Recipe -> Recipe
stirIn recipes base =
    let
        recipeList =
            List.map name recipes |> String.toSentence
    in
        Step
            { name = name base
            , instruction = "stir " ++ recipeList ++ " into " ++ name base
            , subSteps = recipes ++ [ base ]
            }



-- is simmer something different?


boil : Temperature -> Duration -> Recipe -> Recipe
boil temp duration recipe =
    Step
        { name = "boiled " ++ name recipe
        , instruction =
            "Bring "
                ++ name recipe
                ++ " to a boil and adjust heat to "
                ++ Temp.toString temp
                ++ ". Boil for "
                ++ Dur.toString duration
        , subSteps = [ recipe ]
        }


soak : Duration -> Recipe -> Recipe -> Recipe
soak duration liquid recipe =
    Step
        { name = "soaked " ++ name recipe
        , instruction =
            "Soak "
                ++ name recipe
                ++ " in "
                ++ name liquid
                ++ " for "
                ++ Dur.toString duration
        , subSteps = [ recipe ]
        }


beat : Recipe -> Recipe
beat recipe =
    Step
        { name = "beated " ++ name recipe
        , instruction = "Beat " ++ name recipe
        , subSteps = [ recipe ]
        }


pourInto : String -> Recipe -> Recipe
pourInto cookwareName recipe =
    Step
        { name = name recipe
        , instruction = "Pour " ++ name recipe ++ " into a " ++ cookwareName
        , subSteps = [ recipe ]
        }


layer : Int -> String -> List ( Recipe, Amount ) -> Recipe
layer times cookware recipesAndAmounts =
    case List.head recipesAndAmounts of
        Just firstRecipeAndAmount ->
            let
                ( _, otherRecipesAndAmounts ) =
                    List.splitAt 1 recipesAndAmounts

                englishRecipeList =
                    otherRecipesAndAmounts
                        |> List.map recipeAndAmountToString
                        |> String.toSentence
            in
                Step
                    { name = cookware
                    , instruction =
                        "Cover the bottom of a "
                            ++ cookware
                            ++ " with "
                            ++ recipeAndAmountToString firstRecipeAndAmount
                            ++ ". Layer on top "
                            ++ englishRecipeList
                            ++ ". Repeat "
                            ++ Basics.toString (times - 1)
                            ++ " more times."
                    , subSteps = List.map Tuple.first recipesAndAmounts
                    }

        Nothing ->
            Debug.crash "Fix this!"


recipeAndAmountToString : ( Recipe, Amount ) -> String
recipeAndAmountToString ( recipe, amount ) =
    Amounts.toString amount ++ " of the " ++ name recipe


coverTop : String -> Recipe -> Recipe
coverTop productName recipe =
    Step
        { name = name recipe
        , instruction = "Cover " ++ name recipe ++ " with " ++ productName
        , subSteps = [ recipe ]
        }


uncoverTop : Recipe -> Recipe
uncoverTop recipe =
    Step
        { name = name recipe
        , instruction = "Uncover " ++ name recipe
        , subSteps = [ recipe ]
        }


bake : Duration -> Temperature -> Recipe -> Recipe
bake duration temp recipe =
    Step
        { name = name recipe
        , instruction =
            "Bake "
                ++ name recipe
                ++ " for "
                ++ Dur.toString duration
                ++ " at "
                ++ Temp.toString temp
        , subSteps = [ recipe ]
        }


letSit : Duration -> Recipe -> Recipe
letSit duration recipe =
    Step
        { name = name recipe
        , instruction = "Let " ++ name recipe ++ " sit for " ++ Dur.toString duration
        , subSteps = [ recipe ]
        }
