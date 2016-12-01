--Day 6: Probably a Fire Hazard
import qualified Data.Vector as U
import Text.Regex.PCRE

toggle :: Bool -> Bool
toggle True = False
toggle False = True

turnOn :: Bool -> Bool
turnOn _ = True

turnOff :: Bool -> Bool
turnOff _ = False

applySlice :: (a -> a) -> Int -> Int -> U.Vector a -> U.Vector a
applySlice f start end v = a U.++ b U.++ c
    where a = U.take start v
          b = U.map f $ U.slice start (end - start + 1) v
          c = U.drop (end + 1) v

unpack :: String -> [[String]]
unpack s = s =~ "((?:[a-z]+ )+)([0-9]+),([0-9]+) [a-z]+ +([0-9]+),([0-9]+)"

tuplify :: [[String]] -> (String, Int, Int, Int, Int)
tuplify [[_, s, sx, sy, ex, ey]] = (s, read sx, read sy, read ex, read ey)

apply :: (String, Int, Int, Int, Int) -> U.Vector (U.Vector Bool) -> U.Vector (U.Vector Bool)
apply (s, sx, sy, ex, ey) m = applySlice (applySlice f sx ex) sy ey m 
    where 
    f = case s of 
        "turn off " -> turnOff
        "turn on " -> turnOn
        "toggle " -> toggle

day6 = do
    contents <- readFile "day6.txt"
    let lights = foldl (flip $ apply . tuplify . unpack) (U.replicate 1000 (U.replicate 1000 False)) $ lines contents
        numbers = U.map (U.foldl (\n b -> if b == True then n+1 else n) 0) lights
        answer = U.sum numbers
    putStrLn (show answer)

toggle' :: Int -> Int
toggle' = (+2)

turnOn' :: Int -> Int
turnOn' = (+1)

turnOff' :: Int -> Int
turnOff' n
    | n > 0 = n-1
    | otherwise = 0

apply' :: (String, Int, Int, Int, Int) -> U.Vector (U.Vector Int) -> U.Vector (U.Vector Int)
apply' (s, sx, sy, ex, ey) m = applySlice (applySlice f sx ex) sy ey m 
    where 
    f = case s of 
        "turn off " -> turnOff'
        "turn on " -> turnOn'
        "toggle " -> toggle'

day6' = do
    contents <- readFile "day6.txt"
    let lights = foldl (flip $ apply' . tuplify . unpack) (U.replicate 1000 (U.replicate 1000 0)) $ lines contents
        numbers = U.map U.sum lights
        answer = U.sum numbers
    putStrLn (show answer)
