module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String
import Json.Decode exposing (decodeValue)
import Lasagna
import Cookbook.Json.Encode as Encode
import Cookbook.Json.Decode as Decode


all : Test
all =
    describe "The Test Suite"
        [ encodeDecode ]


encodeDecode : Test
encodeDecode =
    let
        recipe =
            Lasagna.lasagna

        encodedAndDecodedRecipe =
            recipe
                |> Encode.recipe
                |> decodeValue Decode.recipe
    in
        test "encoding and decoding a recipe"
            (\_ -> Expect.equal (Ok recipe) encodedAndDecodedRecipe)
