{-# LANGUAGE DeriveGeneric, LambdaCase, DeriveAnyClass #-}
{-# OPTIONS_GHC -Wno-deriving-defaults #-}

module Blog (Blog, Post(..), Metadata, Image, Markdown, parseBlog) where

import Data.Yaml
import Data.Aeson (genericParseJSON, defaultOptions, Options (omitNothingFields, fieldLabelModifier))
import qualified Data.ByteString as BS
import GHC.Generics

type Blog = [Post]

data Post = Post {
    postId :: String,
    metadata :: Maybe Metadata,
    image :: Maybe Image,
    caption :: Maybe Markdown,
    content :: Maybe Markdown
} deriving Generic

instance FromJSON Post where
    parseJSON = genericParseJSON defaultOptions {
        omitNothingFields = True,
        fieldLabelModifier = \case
            "postId" -> "id"
            other -> other
    }

data Metadata = Metadata {
    date :: Maybe String,
    language :: Maybe String,
    location :: Maybe String,
    credits :: Maybe String
} deriving Generic

instance FromJSON Metadata where
    parseJSON = genericParseJSON defaultOptions { omitNothingFields = True }

newtype Image = Image String deriving (Generic, FromJSON)
newtype Markdown = Markdown String deriving (Generic, FromJSON)

parseBlog :: BS.ByteString -> IO Blog
parseBlog = decodeThrow
