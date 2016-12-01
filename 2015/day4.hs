--Day 4: The Ideal Stocking Stuffer
import Data.List
import Data.Digest.Pure.MD5
import qualified Data.ByteString.Lazy.Char8 as C

md5er :: String -> String
md5er = show . md5 . C.pack

day4 = find (\s -> isPrefixOf "00000" (md5er s)) [key ++ show n | n <- [1..]]
    where key = "iwrupvqb"

day4' = find (\s -> isPrefixOf "000000" (md5er s)) [key ++ show n | n <- [1..]]
    where key = "iwrupvqb"
