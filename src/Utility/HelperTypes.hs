-- helper types 
module Utility.HelperTypes where

import Debug.Trace
import Data.List

data NonEmptyList a = NList a [a]

headNL :: NonEmptyList a -> a
headNL (NList a _) = a

tailNL :: NonEmptyList a -> [a]
tailNL (NList _ a) = a

initNL :: NonEmptyList a -> [a]
initNL (NList a b) = if null b
                     then [a]
                     else [a] ++ (init b)

lastNL :: NonEmptyList a -> a
lastNL (NList a b) = if null b
                     then a
                     else last b

lengthNL :: NonEmptyList a -> Int
lengthNL (NList a b) = 1 + length b

nl2List :: NonEmptyList a -> [a]
nl2List (NList a b) = [a] ++ b

fromList2NL :: a -> [a] -> NonEmptyList a
fromList2NL a b = NList a b

getNL :: NonEmptyList a -> Int -> a
getNL a index = if (index >= lengthNL a) || (index < 0)
                then let m = "IndexError :: index out of bounds " ++ show index 
                     in traceStack m (headNL a)
                else (nl2List a) !! index

mapNL :: (a -> b) -> NonEmptyList a -> NonEmptyList b
mapNL f n = let (m:ms) = map f (nl2List n) in fromList2NL m ms

foldlNL :: (a -> b -> a) -> a -> NonEmptyList b -> a
foldlNL f acc n = let ms = nl2List n in foldl f acc ms

zipNL :: NonEmptyList a -> NonEmptyList b -> NonEmptyList (a, b)
zipNL a b = let (m:ms) = zip (nl2List a) (nl2List b) in fromList2NL m ms

sortNL :: Ord a => NonEmptyList a -> NonEmptyList a
sortNL a = let (m:ms) = sort $! nl2List a in fromList2NL m ms
