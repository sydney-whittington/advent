--Day 1: Inverse Captcha
import Data.List
import Data.Char

pair :: [Char] -> [(Char, Char)]
pair [] = []
pair (x:[]) = []
pair (x:y:[]) = [(x, y)]
pair (x:rest@(y:xs)) = (x, y) : pair rest

pairAdd :: (Char, Char) -> Int
pairAdd (a, b)
    | a == b = digitToInt a
    | otherwise = 0

day1 = do
    contents <- readFile "day1.txt"
    let trimmed = init contents
    let paired = pair trimmed ++ [(last trimmed, head trimmed)]
    let answer = sum $ map pairAdd paired
    putStrLn (show answer)

--https://stackoverflow.com/questions/19074520/how-to-split-a-list-into-two-in-haskell
split :: [a] -> ([a], [a])
split myList = splitAt (((length myList) + 1) `div` 2) myList

--this way won't work but I'm keeping it for posterity
day1'bad = do
    contents <- readFile "day1.txt"
    let trimmed = init contents
    let (first, second) = split trimmed
    let shuffled = concat $ transpose [first, second]
    let paired = pair shuffled  ++ [(last second, head first)]
    let answer = sum $ map pairAdd paired
    putStrLn (show answer)

--https://www.reddit.com/r/adventofcode/comments/7gsrc2/2017_day_1_solutions/dqlhkcj/
solve n xs = sum $ zipWith (\a b -> if a == b then a else 0) xs (drop n $ cycle xs)

--learning from my betters
day1' = do
    contents <- readFile "day1.txt"
    let trimmed = init contents
    let half = (length trimmed) `div` 2
    let paired = zip trimmed (drop half $ cycle trimmed)
    let answer = sum $ map pairAdd paired
    putStrLn (show answer)
