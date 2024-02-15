module YesNo where


class YesNo a where
  yesno :: a -> Bool



instance YesNo [a] where
  yesno [] = False
  yesno _ = True



instance YesNo Int where
  yesno 0 = False
  yesno _ = True



instance YesNo Bool where
  yesno b = b



class YesNoLen a where
  yesnoLen :: a -> Int


--ex 9.9.2
instance (YesNo a) => YesNoLen [a] where
  yesnoLen l = length $ filter yesno l

instance YesNo a => YesNo (Maybe a) where
  yesno Nothing  = False
  yesno (Just x) = yesno x