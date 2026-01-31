import Blog
import Converter
import qualified Data.ByteString as BS

main :: IO ()
main = do
    bytes <- BS.getContents
    blog <- parseBlog bytes
    printPosts blog

printPosts :: Blog -> IO ()
printPosts [] = return ()
printPosts (post:posts) = do
    putStrLn (postToHtml post)
    printPosts posts
