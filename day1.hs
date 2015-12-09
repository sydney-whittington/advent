--Day 1: Not Quite Lisp
import Data.List

parenNum :: Char -> Int
parenNum '(' = 1
parenNum ')' = -1
parenNum _ = 0

day1 = do
    contents <- readFile "day1.txt"
    let answer = foldl (+) 0 (map parenNum contents)
    putStrLn (show answer)

day1' = do
    contents <- readFile "day1.txt"
    let positions = scanl (+) 0 (map parenNum contents)
        answer = findIndex (== -1) positions
    putStrLn (show answer)

