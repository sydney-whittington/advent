--Day 3: Perfectly Spherical Houses in a Vacuum
import qualified Data.Map.Strict as Map

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

