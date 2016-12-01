--Day 10: Elves Look, Elves Say
import Data.List

lookSay :: String -> String
lookSay s = foldr (\g acc -> (head . show $ length g) : head g : acc) "" (group s)

day10 = length $ (!! 40) (iterate lookSay "1321131112")

day10' = length $ (!! 50) (iterate lookSay "1321131112")
