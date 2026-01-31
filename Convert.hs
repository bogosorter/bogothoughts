import Blog

main :: IO ()
main = do
    blog <- parseBlog "blog.yaml"
    printNames blog

printNames :: Blog -> IO ()
printNames [] = return ()
printNames (post:posts) = do
    putStrLn (postId post)
    printNames posts
