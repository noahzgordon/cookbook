module Cookbook.Generators exposing (..)

import Cookbook.Recipe exposing (..)
import String.Extra as String
import List.Extra as List


listTechnique : String -> (List Recipe -> String) -> (List Recipe -> Recipe)
listTechnique name fn =
    \recipes ->
        Step
            { name = name
            , instruction = fn recipes
            , subSteps = recipes
            }


techniqueWithTempAndDuration : String -> (Recipe -> Temperature -> Duration -> String) -> (Recipe -> Recipe)
techniqueWithTempAndDuration name fn =
    \recipe temp dur ->
        Step
            { name = name
            , instruction = fn recipe temp dur
            , subSteps = [ recipe ]
            }
