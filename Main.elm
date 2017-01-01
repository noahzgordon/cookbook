module Main exposing (main)

import Cookbook
import Cookbook.Ingredients exposing (bread, peanutButter, jelly)
import Cookbook.Techniques exposing (spread, placeOnTop)


main =
    Cookbook.generateHtml sandwich


pbHalf : Cookbook.Component
pbHalf =
    spread peanutButter bread


jellyHalf : Cookbook.Component
jellyHalf =
    spread jelly bread


sandwich : Cookbook.Component
sandwich =
    placeOnTop pbHalf jellyHalf
