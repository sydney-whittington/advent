--Day 13: Knights of the Dinner Table
import Text.Regex.PCRE
import qualified Data.Map.Lazy as Map
import qualified Data.Set as Set
import Data.List

type Pairings = Map.Map (String, String) Int
type Table = [String]

buildPairing :: Pairings -> String -> Pairings
buildPairing p s = Map.insert k v p
    where [[_, p1, sign, v', p2]] = extractPairing s
          k = (p1, p2)
          v = if sign == "gain"
                 then read v'
                 else 0 - read v'

extractPairing :: String -> [[String]]
extractPairing s = s =~ "([A-Z][a-z]+)[ a-z]*(gain|lose) ([0-9]+)[ a-z]*([A-Z][a-z]+).*"

getPeople :: [String] -> [String]
getPeople = Set.toList . Set.fromList . concatMap getPair
    where getPair = (\[(_:n1:n2:_)] -> [n1, n2]) . extractNames

extractNames :: String -> [[String]]
extractNames s = s =~ "([A-Z][a-z]+)[ a-z0-9]*([A-Z][a-z]+).*"

totalTable :: Pairings -> Table -> Int
totalTable p t = totalOneWay p circle + totalOneWay p (reverse circle)
    where circle = take (length t + 1) $ cycle t
          
totalOneWay :: Pairings -> Table -> Int
totalOneWay p (a:b:[]) = p Map.! (a, b)
totalOneWay p (a:xs@(b:_)) = p Map.! (a, b) + totalOneWay p xs

day13 = do
    contents <- readFile "day13.txt"
    let pairings = foldl buildPairing Map.empty (lines contents) 
        people = getPeople $ lines contents
        options = permutations people
        answer = maximum $ map (totalTable pairings) options
    putStrLn (show answer)

day13' = do
    contents <- readFile "day13.txt"
    let otherPeople = getPeople $ lines contents
        apathy = Map.fromList ([(("me", n), 0) | n <- otherPeople] ++ [((n, "me"), 0) | n <- otherPeople])
        people = "me" : otherPeople
        pairings = foldl buildPairing apathy (lines contents) 
        options = permutations people
        answer = maximum $ map (totalTable pairings) options
    putStrLn (show answer)
