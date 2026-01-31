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

metadataToHtml :: Maybe Metadata -> Html ()
metadataToHtml Nothing = return ()
metadataToHtml (Just metadata) = div_ [class_ "metadata"] $ do
    dateToHtml (date metadata)
    languageToHtml (language metadata)
    locationToHtml (location metadata)
    creditsToHtml (credits metadata)

dateToHtml :: Maybe String -> Html()
dateToHtml Nothing = return ()
dateToHtml (Just d) = p_ [class_ "date"] (toHtml (pack d))

languageToHtml :: Maybe String -> Html()
languageToHtml Nothing = return ()
languageToHtml (Just lang) = p_ [class_ "language"] (toHtml (pack lang))

locationToHtml :: Maybe String -> Html()
locationToHtml Nothing = return ()
locationToHtml (Just loc) = p_ [class_ "location"] (toHtml (pack loc))

creditsToHtml :: Maybe String -> Html()
creditsToHtml Nothing = return ()
creditsToHtml (Just cred) = p_ [class_ "credits"] (toHtml (pack cred))

imageToHtml :: Maybe Image -> Html()
imageToHtml Nothing = return ()
imageToHtml (Just (Image src)) = img_ [src_ (pack src)]

captionToHtml :: Maybe Markdown -> Html()
captionToHtml Nothing = return ()
captionToHtml (Just (Markdown md)) = toHtmlRaw (commonmarkToHtml [] [] (pack md))
