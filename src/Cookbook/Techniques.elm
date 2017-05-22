module Cookbook.Techniques exposing (..)

import Cookbook.Recipe exposing (..)


type alias RecordOne =
    { name : Recipe -> String
    , instruction : Recipe -> String
    }


techniqueOne : RecordOne -> (Recipe -> Recipe)
techniqueOne record =
    \recipe ->
        Step
            { name = record.name recipe
            , instruction = record.instruction recipe
            , subSteps = [ recipe ]
            }


withTemperature : Temperature -> (a -> Recipe) -> (Temperature -> a -> Recipe)
withTemperature temp func =
    
