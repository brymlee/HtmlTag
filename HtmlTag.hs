{-# LANGUAGE ExistentialQuantification #-}
module HtmlTag where 

class Tag_ a where
    html :: a -> String

data Tag = forall a. Tag_ a => Tag a 

instance Tag_ Tag where
    html (Tag a) = html a

data Attribute = Attribute String String deriving (Eq, Show)

data BeginningTag = BeginningTag String [Attribute] deriving (Eq, Show)
beginningTag :: String -> [Attribute] -> Tag 
beginningTag a b = Tag (BeginningTag a b)

data EndingTag = EndingTag String deriving (Eq, Show)
endingTag :: String -> Tag
endingTag a = Tag (EndingTag a)

data FullTag = FullTag BeginningTag (Maybe String) EndingTag deriving (Eq, Show)
fullTag :: BeginningTag -> Maybe String -> EndingTag -> Tag
fullTag a b c = Tag (FullTag a b c)

data Nest = Nest String [Tag] 

concatenateAttributesAsString :: [Attribute] -> String 
concatenateAttributesAsString attributes = (init $ foldr (++) " " (map (\ (Attribute name value) -> name ++ "=" ++ value) attributes))

instance Tag_ BeginningTag where
    html (BeginningTag name attributes) | length attributes == 0 = "<" ++ name ++ "" ++ (concatenateAttributesAsString attributes) ++ ">"
                                        | length attributes > 0 = "<" ++ name ++ " " ++ (concatenateAttributesAsString attributes) ++ ">"

instance Tag_ EndingTag where
    html (EndingTag name) = "</" ++ name ++ ">"

instance Tag_ FullTag where
    html (FullTag beginningTag (Just text) endingTag) = (html beginningTag) ++ text ++ (html endingTag) 

instance Tag_ Nest where
    html (Nest parentLevelTagName children) = (html (BeginningTag parentLevelTagName [])) 
                                            ++ (foldr (++) "" (map (\ (Tag a) -> html a) children))
                                            ++ (html (EndingTag parentLevelTagName))
