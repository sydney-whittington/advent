--Day 2: Corruption Checksum

module Day2 where

import Data.List
import Data.List.Split

checksum :: [Int] -> Int
checksum xs = maximum xs - minimum xs

day2 = do
    contents <- readFile "src/inputs/day2.txt"
    let rows = lines contents
        answer = sum $ map (checksum . map read . splitOn "\t") rows
    print answer

divisible :: [Int] -> Int
divisible xs = uncurry div pair
    where pair = head [ (x, y) | x<-xs, y<-xs, x /= y, x `mod` y == 0]

day2' = do
    contents <- readFile "src/inputs/day2.txt"
    let rows = lines contents
        answer = sum $ map (divisible . map read . splitOn "\t") rows
    print answer
