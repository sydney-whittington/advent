--Day 8: Matchsticks
realCount :: String -> Int
realCount [] = 0
realCount ('"':xs) = 0 + realCount xs
realCount ('\\':'\\':xs) = 1 + realCount xs
realCount ('\\':'\"':xs) = 1 + realCount xs
realCount ('\\':'x':_:_:xs) = 1 + realCount xs
realCount (_:xs) = 1 + realCount xs

day8 = do
    contents <- readFile "day8.txt"
    let strings = lines contents
        chars = sum $ map length strings
        realChars = sum $ map realCount strings
        answer = chars - realChars
    putStrLn (show answer)

day8' = do
    contents <- readFile "day8.txt"
    let strings = lines contents
        chars = sum $ map length strings
        encodedChars = sum $ map (length . show) strings
        answer = encodedChars - chars
    putStrLn (show answer)
