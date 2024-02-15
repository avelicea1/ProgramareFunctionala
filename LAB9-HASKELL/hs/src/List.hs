module List where

import Data.Monoid

data List a = Nil | Cons a (List a) deriving Show

instance Semigroup (List a) where 
  l1 <> Nil = l1
  Nil <> l2 = l2
  (Cons x xs) <> ys = Cons x (xs <> ys)

instance Monoid (List a) where
  mempty = Nil

appLists :: (Monoid a) => [a] -> a
appLists = foldl (<>) mempty

--ex 9.9
newtype AllUpper = AllUpper Bool deriving (Show)
newtype AnyLower = AnyLower Bool deriving (Show)
instance Semigroup AllUpper where
  (AllUpper x) <> (AllUpper y) = AllUpper (x && y)
instance Semigroup AnyLower where
  (AnyLower x) <> (AnyLower y) = AnyLower (x || y)
instance Monoid AllUpper where
  mempty = AllUpper True
instance Monoid AnyLower where
  mempty = AnyLower False
allUpper :: String -> Bool
allUpper = getAll . foldMap (\c -> All (isUpper c))
  where
    isUpper c = c >= 'A' && c <= 'Z'
allUpperAny :: String -> Bool
allUpperAny = not . getAny . foldMap (\c -> Any (isLower c))
  where
    isLower c = c >= 'a' && c <= 'z'
