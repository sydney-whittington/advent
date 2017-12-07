--Day 5: A maze of Twisty Trampolines, All Alike

module Day5 where

import Data.Sequence

fred :: String -> Int
fred = read

jump :: Seq Int -> Int -> Int
jump xs pos = pos + index xs pos

offset :: Seq Int -> Int -> Seq Int
offset xs pos = update pos (index xs pos + 1) xs

nextStep :: (Seq Int, Int) -> (Seq Int, Int)
nextStep (xs, pos) = (offset xs pos, jump xs pos)

day5 = do
    contents <- readFile "src/inputs/day5.txt"
    let array = fromList . map fred $ lines contents
        answer = Prelude.length . takeWhile (\(xs, pos) -> pos < Data.Sequence.length array && pos >= 0) $ iterate nextStep (array, 0)
    print answer

offset' :: Seq Int -> Int -> Seq Int
offset' xs pos = update pos (index xs pos + adjust (index xs pos)) xs
    where adjust x = if x >= 3 then -1 else 1

nextStep' :: (Seq Int, Int) -> (Seq Int, Int)
nextStep' (xs, pos) = (offset' xs pos, jump xs pos)

day5' = do
    contents <- readFile "src/inputs/day5.txt"
    let array = fromList . map fred $ lines contents
        answer = Prelude.length . takeWhile (\(xs, pos) -> pos < Data.Sequence.length array && pos >= 0) $ iterate nextStep' (array, 0)
    print answer
