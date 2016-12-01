--Day 11: Corporate Policy
import Data.List

next :: String -> String
next ('z':xs) = 'a' : next xs
next (x:xs) = succ x : xs

increment :: String -> String
increment = reverse . next . reverse
    
fIsInfixOf :: ([a] -> Bool) -> [a] -> Bool
fIsInfixOf f xs = any f (tails xs)

threeIncreasing :: String -> Bool
threeIncreasing (a:b:c:_) = succ a == b && succ b == c
threeIncreasing _ = False

noConfusing :: String -> Bool
noConfusing w = (length $ confusing w) == 0
    where confusing = filter $ flip elem "iol"

twoPairs :: String -> Bool
twoPairs = (>1) . length . filter (>1) . map length . group

valid :: String -> Bool
valid w = fIsInfixOf threeIncreasing w && noConfusing w && twoPairs w

day11 = find valid $ iterate increment "hxbxwxba"

day11' = find valid $ iterate increment (increment "hxbxxyzz")
