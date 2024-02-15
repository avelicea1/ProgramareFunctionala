unfold p h t x
  | p x = []
  | otherwise = (h x) : unfold p h t (t x)

-- seria A 2023
-- s1 = i (\n -> n * 2) 2
-- where
-- i f x = x : i f (f x)

-- 2022
s1 = [2 ^ n | n <- [0, 2 ..]]

f g h i j
  | g j = []
  | otherwise = (h j) : f g h i (i j)

s2 = f g h i [0, 1 ..]
  where
    g = \ns -> ns == []
    h = \ns -> s1 !! (head ns)
    i = \ns -> tail ns