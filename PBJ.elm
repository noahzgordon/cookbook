module PBJ exposing (main)

import Cookbook exposing (..)


main =
    Cookbook.generateHtml sandwich


sandwich : Cookbook.Recipe
sandwich =
    PlaceOnTop pbHalf jellyHalf


pbHalf : Cookbook.Recipe
pbHalf =
    Spread peanutButter bread


jellyHalf : Cookbook.Recipe
jellyHalf =
    Spread jelly bread


jelly : Cookbook.Recipe
jelly =
    Ingredient "jelly"


peanutButter : Cookbook.Recipe
peanutButter =
    Ingredient "peanut butter"


bread : Cookbook.Recipe
bread =
    Ingredient "white bread"
