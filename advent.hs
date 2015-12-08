import Data.List
import Data.List.Split
import qualified Data.Map.Strict as Map

import Data.Digest.Pure.MD5
import qualified Data.ByteString.Lazy.Char8 as C

import Text.Regex.PCRE

import Data.Matrix

--Day 1: Not Quite Lisp
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

--Day 2:  I Was Told There Would Be No Math
wrapping :: Int -> Int -> Int -> Int
wrapping l w h
    | x <= y && x <= z = 3*x + 2*y + 2*z
    | y <= x && y <= z = 2*x + 3*y + 2*z
    | z <= x && z <= y = 2*x + 2*y + 3*z
    where x = l * w
          y = w * h
          z = h * l

wrapping' [l,w,h] = wrapping l w h

ribbon :: Int -> Int -> Int -> Int
ribbon l w h
    | x <= y && x <= z = 2*l + 2*w + l*w*h
    | y <= x && y <= z = 2*w + 2*h + l*w*h
    | z <= x && z <= y = 2*h + 2*l + l*w*h
    where x = l * w
          y = w * h
          z = h * l

ribbon' [l,w,h] = ribbon l w h

day2 = do
    contents <- readFile "day2.txt"
    let boxes = lines contents
        dimensions = map (map read) $ map (splitOn "x") boxes
        answer = sum (map wrapping' dimensions)
    putStrLn (show answer)

day2' = do
    contents <- readFile "day2.txt"
    let boxes = lines contents
        dimensions = map (map read) $ map (splitOn "x") boxes
        answer = sum (map ribbon' dimensions)
    putStrLn (show answer)

--Day 3: Perfectly Spherical Houses in a Vacuum
delivery :: (Map.Map (Int, Int) Int, Int, Int) -> Char -> (Map.Map (Int, Int) Int, Int, Int)
delivery (houses, x, y) d
    | d == '^' = ((Map.insertWith (+) (x, y+1) 1 houses), x, y+1) 
    | d == 'v' = ((Map.insertWith (+) (x, y-1) 1 houses), x, y-1) 
    | d == '<' = ((Map.insertWith (+) (x-1, y) 1 houses), x-1, y) 
    | d == '>' = ((Map.insertWith (+) (x+1, y) 1 houses), x+1, y) 

day3 = do
    contents <- readFile "day3.txt"
    let houses = foldl delivery (Map.singleton (0,0) 1, 0, 0) contents
        answer = Map.size $ (\(locations, x, y) -> locations) houses
    putStrLn (show answer)

every n xs = case drop (n-1) xs of
              (y:ys) -> y : every n ys
              [] -> []

day3' = do
    contents <- readFile "day3.txt"
    let houses = foldl delivery (Map.singleton (0,0) 1, 0, 0) (take 1 contents ++ every 2 (drop 1 contents))
        roboHouses = foldl delivery (Map.singleton (0,0) 1, 0, 0) (every 2 $ contents)
        f = (\(locations, x, y) -> locations)
        allHouses = Map.unionWith (+) (f houses) (f roboHouses)
        answer = Map.size allHouses
    putStrLn (show answer)

--Day 4: The Ideal Stocking Stuffer
md5er :: String -> String
md5er = show . md5 . C.pack

day4 = find (\s -> isPrefixOf "00000" (md5er s)) [key ++ show n | n <- [1..]]
    where key = "iwrupvqb"

day4' = find (\s -> isPrefixOf "000000" (md5er s)) [key ++ show n | n <- [1..]]
    where key = "iwrupvqb"

--Day 5: Doesn't He Have Intern-Elves For This?
hasVowels :: String -> Bool
hasVowels w = (length $ onlyVowels w) >= 3
    where onlyVowels = filter $ flip elem "aeiou"

hasRepeats :: String -> Bool
hasRepeats = any (>1) . map length . group

noBadness :: String -> Bool
noBadness w = all (==False) $ map ($ w) (map (isInfixOf) badness)
    where badness = ["ab", "cd", "pq", "xy"]

allTests :: String -> Bool
allTests w = hasVowels w && hasRepeats w && noBadness w 

day5 = do
    contents <- readFile "day5.txt"
    let results = map allTests $ lines contents
        answer = length $ filter (==True) results
    putStrLn (show answer)

hasPairs :: String -> Bool
hasPairs w = w =~ "(..).*\\1"

hasSurround :: String -> Bool
hasSurround w = w =~ "(.).\\1"

allTests' :: String -> Bool
allTests' w = hasPairs w && hasSurround w

day5' = do
    contents <- readFile "day5.txt"
    let results = map allTests' $ lines contents
        answer = length $ filter (==True) results
    putStrLn (show answer)

--Day 6: Probably a Fire Hazard
lights :: String -> Matrix -> Matrix
