--Day 5: Doesn't He Have Intern-Elves For This?
import Text.Regex.PCRE

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


