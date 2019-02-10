import Assert
import HtmlTag

main :: IO()
main = do
    let attributeIdHello = (Attribute "id" "hello")
    assertEquals "Does attribute with name as id and value as hello equal itself?" attributeIdHello attributeIdHello
    let beginningTag = (BeginningTag "div" [(Attribute "hello" "goodbye")]) 
    assertEquals "Does tag with name as div and one attribute with name as hello and value as goodbye equal itself?" beginningTag beginningTag
    assertEquals "When getting HTML for beginning tag div then HTML should be correct." 
        (html (BeginningTag "div" [(Attribute "hello" "goodbye")]))
        "<div hello=goodbye>"
    assertEquals "When getting HTML for ending tag div then HTML should be correct."
        (html (EndingTag "div")) 
        "</div>"
    assertEquals "When getting HTML for full tag with p then HTML should be correct."
        (html (FullTag (BeginningTag "p" []) (Just "hello") (EndingTag "p")))
        "<p>hello</p>"
    assertEquals "When getting HTML for basic hello world document then HTML should be correct."
        (html (Nest "html" [(fullTag (BeginningTag "p" []) (Just "hello world") (EndingTag "p"))]))
        "<html><p>hello world</p></html>"
        
