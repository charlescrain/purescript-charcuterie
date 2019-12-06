module Test.Main where

import Prelude

import Data.Either (Either)
import Data.Foldable (oneOf)
import Effect (Effect)
import Effect.Class.Console (logShow)
import Routing (match)
import Routing.Match (Match(..), int, lit, root, str)

main :: Effect Unit
main = do
  -- logShow $ matchMyRoute "/"
  logShow $ matchMyRoute "/posts"

matchMyRoute :: String -> Either String MyRoute
matchMyRoute = match myRoute

type PostId = Int

data MyRoute
  = PostIndex
  | Post PostId
  | PostEdit PostId
instance myRouteShow :: Show MyRoute where
  -- show Index = "Index"
  show PostIndex = "PostIndex"
  show _ = "Who cares"

myRoute :: Match MyRoute
myRoute = root *> oneOf
  [ PostIndex <$ lit "posts"
  , Post <$> (lit "posts" *> int)
  , PostEdit <$> (lit "posts" *> int <* lit "edit")
  ]