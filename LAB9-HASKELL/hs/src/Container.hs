module Container where


class Container c where
  hasElem :: (Eq a) => c a -> a -> Bool
  nrElems :: c a -> Int



instance Container Maybe where
  hasElem (Just x) e = x == e
  hasElem _ _ = False

  nrElems (Just _) = 1
  nrElems _ = 0



instance Container [] where
  hasElem l e = elem e l

  nrElems l = length l

--ex 9.9.3
data Tree a = Nil | Node (Tree a) a (Tree a)


instance Container Tree where
  hasElem Nil _ = False
  hasElem (Node left val right) x
    | val == x = True
    | otherwise = hasElem left x || hasElem right x
  nrElems Nil = 0
  nrElems (Node left _ right) = 1 + nrElems left + nrElems right


