--Day 1: Inverse Captcha

module Day1 where

import Data.List
import Data.Char

pair :: String -> [(Char, Char)]
pair [] = []
pair [x] = []
pair [x,y] = [(x, y)]
pair (x:rest@(y:xs)) = (x, y) : pair rest

pairAdd :: (Char, Char) -> Int
pairAdd (a, b)
    | a == b = digitToInt a
    | otherwise = 0

day1 = do
    contents <- readFile "src/inputs/day1.txt"
    let trimmed = init contents
        paired = pair trimmed ++ [(last trimmed, head trimmed)]
        answer = sum $ map pairAdd paired
    print answer

--https://www.reddit.com/r/adventofcode/comments/7gsrc2/2017_day_1_solutions/dqlhkcj/
solve n xs = sum $ zipWith (\a b -> if a == b then a else 0) xs (drop n $ cycle xs)

--learning from my betters
day1' = do
    contents <- readFile "src/inputs/day1.txt"
    let trimmed = init contents
        half = length trimmed `div` 2
        paired = zip trimmed (drop half $ cycle trimmed)
        answer = sum $ map pairAdd paired
    print answer
