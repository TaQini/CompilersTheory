import Control.Exception
import Data.Time

main = do a <- readFile "raw.dat"
--IO String -> String
-- words
          begin <- getCurrentTime
          evaluate (mergesort ((atoi (words a))))
          end <- getCurrentTime
          print(diffUTCTime end begin)

-- atoi 
atoi list = map toi list
toi item = read item :: Int

-- mergesort
mergesort [] = [] 
mergesort [a] = [a]
mergesort a = let pulka = length a `div` 2 in merge (mergesort $ take pulka a) (mergesort $ drop pulka a) 

-- merge
merge a [] = a
merge [] a = a
merge (a:ra) (b:rb) = if a > b then ([b] ++ (merge (a:ra) (rb))) else ([a] ++ (merge (ra) (b:rb)))
