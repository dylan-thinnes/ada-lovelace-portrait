main :: IO ()
main = interact convert

convert :: String -> String
convert inp =
    let (header:comment:sizes:precision:rawDat) = lines inp

        -- data
        [x, y] = map (read :: String -> Int) $ words sizes
        dat = map (read :: String -> Int) rawDat

        -- svg builders
        toRect x y = concat ["<circle cx='", show x, "' cy='", show y, "' r='0.40' stroke='black' stroke-width='0.05'></circle>"]
        toDocument s = concat ["<svg version='1.1' width='", show x, "' height='", show y, "' xmlns='http://www.w3.org/2000/svg'>", s, "</svg>"]

        -- render
        ixes = (,,) <$> [0..y-1] <*> [0..x-1] <*> [0,1,2]
        rects = concatMap (\((y,x,n),val) -> if n == 0 && val < 130 then toRect x y else "") $ zip ixes dat
    in
    toDocument rects
