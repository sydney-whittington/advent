--Day 4: High-Entropy Passphrases

module Day4 where

import Data.List

day4 = do
    contents <- readFile "src/inputs/day4.txt"
    let phrases = lines contents
        lists = map words phrases
        answer = sum $ map (\x -> if nub x == x then 1 else 0) lists
    print answer

day4' = do
    contents <- readFile "src/inputs/day4.txt"
    let phrases = lines contents
        lists = map (map sort . words) phrases
        answer = sum $ map (\x -> if nub x == x then 1 else 0) lists
    print answer
