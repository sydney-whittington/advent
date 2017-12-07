--Day 3: Spiral Memory

module Day3 where

--biggerSquare :: Int -> Int
biggerSquare x = head . dropWhile (<x) $ map (^2) [1,3..]

distance square x = sqrt square - (square - x) - 1

day3 = do
    let target = 277678
        square = biggerSquare target
        answer = distance square target
    print answer

--day3' = "https://oeis.org/A141481"