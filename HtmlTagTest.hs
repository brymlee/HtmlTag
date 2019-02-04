import Assert
import HtmlTag

main :: IO()
main = do
    assertEquals "Does attribute with name as id and value as hello equal itself?" 
        (Attribute "id" "hello") (Attribute "id" "hello")
    assertEquals "Does tag with name as div and one attribute with name as hello and value as goodbye equal itself?" 
        (BeginningTag "div" [(Attribute "hello" "goodbye")])
        (BeginningTag "div" [(Attribute "hello" "goodbye")])
    assertEquals "When getting HTML for tag div then HTML should be correct." 
        (html (BeginningTag "div" [(Attribute "hello" "goodbye")]))
        "<div hello=goodbye >"
        