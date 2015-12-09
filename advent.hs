import Data.List
import Data.List.Split
import qualified Data.Map.Strict as Map

import Data.Digest.Pure.MD5
import qualified Data.ByteString.Lazy.Char8 as C

import Text.Regex.PCRE

import Data.Matrix

--Day 6: Probably a Fire Hazard
lights :: String -> Matrix -> Matrix
