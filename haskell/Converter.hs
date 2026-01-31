{-# LANGUAGE OverloadedStrings #-}

module Converter where

import Blog
import Lucid
import CMarkGFM
import Prelude hiding (id)
import Data.Text (pack)
import Data.Text.Lazy (unpack)

postToHtml :: Post -> String
postToHtml post = unpack (renderText html)
    where html = article_ [id_ (pack (postId post))] $ do
            imageToHtml (image post)
            metadataToHtml (metadata post)
            captionToHtml (caption post)
            bodyToHtml (body post)

metadataToHtml :: Maybe Metadata -> Html ()
metadataToHtml Nothing = return ()
metadataToHtml (Just metadata) = div_ [class_ "metadata"] $ do
    dateToHtml (date metadata)
    languageToHtml (language metadata)
    locationToHtml (location metadata)
    creditsToHtml (credits metadata)

dateToHtml :: Maybe String -> Html()
dateToHtml Nothing = return ()
dateToHtml (Just d) = span_ [class_ "date"] (toHtml (pack d))

languageToHtml :: Maybe String -> Html()
languageToHtml Nothing = return ()
languageToHtml (Just lang) = span_ [class_ "language"] (toHtml (pack lang))

locationToHtml :: Maybe String -> Html()
locationToHtml Nothing = return ()
locationToHtml (Just loc) = span_ [class_ "location"] (toHtml (pack loc))

creditsToHtml :: Maybe String -> Html()
creditsToHtml Nothing = return ()
creditsToHtml (Just cred) = span_ [class_ "credits"] (toHtml (pack cred))

imageToHtml :: Maybe Image -> Html()
imageToHtml Nothing = return ()
imageToHtml (Just (Image src)) = img_ [src_ (pack ("./images/" ++ src))]

captionToHtml :: Maybe Markdown -> Html()
captionToHtml Nothing = return ()
captionToHtml (Just (Markdown md)) = div_ [class_ "caption"] $ toHtmlRaw (commonmarkToHtml [] [] (pack md))

bodyToHtml :: Maybe Markdown -> Html()
bodyToHtml Nothing = return ()
bodyToHtml (Just (Markdown md)) = div_ [class_ "body"] $ toHtmlRaw (commonmarkToHtml [] [] (pack md))
