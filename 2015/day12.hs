--Day 12: JSAbacusFramework.io
import Data.List.Split
import Data.Char

stripNumbers :: String -> [Int]
stripNumbers = map read . wordsBy (\x -> not (isDigit x || '-' == x))

day12 = do
    contents <- readFile "day12.txt"
    let answer = sum $ stripNumbers contents
    putStrLn (show answer)

day12' = do
    contents <- readFile "day12_2.txt"
    let answer = sum $ stripNumbers contents
    putStrLn (show answer)
