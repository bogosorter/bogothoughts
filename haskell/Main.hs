{-# LANGUAGE OverloadedStrings #-}

import Blog
import Converter
import Data.Text (pack, breakOn, length)
import Prelude hiding (length)
import qualified Data.ByteString as BS

main :: IO ()
main = do
    -- Read the blog's source YAML
    bytes <- BS.getContents
    blog <- parseBlog bytes

    -- Generate HTML and replace fill the template
    template <- readFile "template.html"
    putStr (fillTemplate template (renderBlog blog))

renderBlog :: Blog -> String
renderBlog = concatMap postToHtml

fillTemplate :: String -> String -> String
fillTemplate template content = templateHead ++ content ++ templateTail
    where
        position = contentPosition "{{ posts }}" template
        templateHead = take position template
        templateTail = drop (position + length "{{ posts }}") template

contentPosition :: String -> String -> Int
contentPosition needle haystack =
    let (before, after) = breakOn (pack needle) (pack haystack)
    in case after of
        "" -> error "dangerous error"
        _ -> length before
