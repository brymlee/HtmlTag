module HtmlTag where 

import Assert

data Attribute = Attribute String String deriving (Eq, Show)

data BeginningTag = BeginningTag String [Attribute] deriving (Eq, Show)
               
data EndingTag = EndingTag String

concatenateAttributesAsString :: [Attribute] -> String 
concatenateAttributesAsString attributes = foldr (++) " " (map (\ (Attribute name value) -> name ++ "=" ++ value) attributes)

class Html a where
    html :: a -> String

instance Html BeginningTag where
    html (BeginningTag name attributes) = "<" ++ name ++ " " ++ (concatenateAttributesAsString attributes) ++ ">"
