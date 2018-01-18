check :: Integer -> Integer -> [Integer] -> Integer
check acm v xs
    | null xs   = acm
    | otherwise = check (acm + (abs ((head xs) - v))) v (tail xs)

ternary :: Integer -> Integer -> [Integer] -> Integer
ternary hi lo xs
    | hi - lo <= 2 = lo
    | (check 0 mid1 xs) > (check 0 mid2 xs) = ternary mid1 lo xs
    | otherwise = ternary hi mid2 xs
    where
        mid1 = (2 * hi + lo) `div` 3
        mid2 = (hi + 2 * lo) `div` 3

main :: IO ()
main = do
    [n] <- fmap (map read . words) getLine :: IO [Integer]
    xs  <- fmap (map read . words) getLine :: IO [Integer]
    let lo = ternary 1000000000 (-1000000000) xs
    print $ min (min (check 0 lo xs) (check 0 (lo + 1) xs)) (check 0 (lo + 2) xs)
