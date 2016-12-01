--Day 14: Reindeer Olympics
import Data.Char
import Data.List
import qualified Data.Map.Lazy as Map

distance :: Int -> Int -> Int -> Int -> Int
distance speed duration rest end
    | end > duration + rest = distance speed duration rest (end - duration - rest) + sprint
    | end > duration = sprint
    | otherwise = speed * end
    where sprint = speed * duration

day14 = do
    contents <- readFile "day14.txt"
    let reindeer = map (map read . filter (all (==True) . map isDigit)) . map words $ lines contents
        results = map (\[s, d, r] -> distance s d r 2503) reindeer
        answer = maximum results
    putStrLn (show answer)

scores :: [Int] -> Map.Map Int Int -> Map.Map Int Int
scores xs s = foldl (\s x -> Map.insertWith (+) x 1 s) s best
    where best = findIndices (== maximum xs) xs

day14' = do
    contents <- readFile "day14.txt"
    let reindeer = map (map read . filter (all (==True) . map isDigit)) . map words $ lines contents
        progress = transpose $ map (\[s, d, r] -> map (distance s d r) [1..2503]) reindeer
        results = foldr scores Map.empty progress 
    putStrLn (show results)
