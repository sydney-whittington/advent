import qualified Data.Map.Lazy as Map
import qualified Data.Set as Set
import Data.List

type Paths = Map.Map (Set.Set String) Int

buildPath :: Paths -> String -> Paths
buildPath p s = Map.insert k v p
    where [p1, _, p2, _, v'] = words s
          k = Set.fromList [p1, p2]
          v = read v'
          
getCities :: [String] -> [String]
getCities = Set.toList . Set.fromList . concatMap getCity
    where getCity s = (\(c1:_:c2:xs) -> [c1, c2]) $ words s

pairList :: [a] -> [(a, a)]
pairList [] = []
pairList (x:[]) = []
pairList (x:y:[]) = [(x,y)]
pairList (x:xs@(y:_)) = (x,y) : pairList xs

distance :: [String] -> Paths -> Int
distance xs p = sum paths
    where pairs = pairList xs
          sets = map (Set.fromList . (\(a, b) -> [a, b])) pairs
          paths = map (p Map.!) sets

day9 = do
    contents <- readFile "day9.txt"
    let paths = foldl buildPath Map.empty (lines contents) 
        cities = getCities $ lines contents
        options = permutations cities
        answer = minimum $ map (flip distance $ paths) options
    putStrLn (show answer)

day9' = do
    contents <- readFile "day9.txt"
    let paths = foldl buildPath Map.empty (lines contents) 
        cities = getCities $ lines contents
        options = permutations cities
        answer = maximum $ map (flip distance $ paths) options
    putStrLn (show answer)
