module Bagel exposing (main, bagel)

import Cookbook exposing (..)
import Cookbook.Recipe exposing (..)
import Cookbook.Amounts exposing (..)


main =
    Cookbook.generateHtml bagel


bagel : Recipe
bagel =
    let
        ( top, bottom ) =
            ingredient (num 1) "poppy seed bagel"
                |> toast
                |> sliceInHalf
    in
        bottom
            |> spread (ingredient (2 |> ounces) "cream cheese")
            |> placeOnTop (ingredient (1 / 4 |> pounds) "smoked salmon")
            |> placeOnTop (ingredient (num 1) "slice of onion")
            |> placeOnTop top
