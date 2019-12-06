module Routes where

import Prelude
import Data.Foldable (oneOf)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Page.Activity (mkActivity)
import React.Basic (JSX, element)
import React.Basic.DOM (text)
import Routing.Match (Match, end, lit, root)

data AppRoute
  = IndexRoute
  | ActivityRoute

route :: Maybe AppRoute -> Effect (Array JSX)
route = case _ of
  Nothing -> page404
  Just IndexRoute -> pageHome
  Just ActivityRoute -> do
    activity <- mkActivity
    pure $ [ element activity {} ]

page404 :: Effect (Array JSX)
page404 = pure [ text "404 Page" ]

pageHome :: Effect (Array JSX)
pageHome = pure [ text "Home" ]

pageActivity :: Effect (Array JSX)
pageActivity = pure [ text "Activity" ]

appRoutes :: Match AppRoute
appRoutes =
  root
    *> oneOf
        [ ActivityRoute <$ lit "activity" <* end
        , IndexRoute <$ end
        ]

maybeAppRoutes :: Match (Maybe AppRoute)
maybeAppRoutes = oneOf [ Just <$> appRoutes, pure Nothing ]
