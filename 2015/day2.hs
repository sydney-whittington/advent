--Day 2:  I Was Told There Would Be No Math
import Data.List
import Data.List.Split

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

