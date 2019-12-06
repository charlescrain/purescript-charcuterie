module React.InfiniteScroll where

import Prelude
import Effect (Effect)
import React.Basic (JSX, ReactComponent)

foreign import infiniteScroll ::
  ReactComponent
    { children :: Array JSX
    , next :: Effect Unit
    , hasMore :: Boolean
    , dataLength :: Int
    , loader :: JSX
    , endMessage :: JSX
    }

mkInfiniteScroll ::
  Effect
    ( ReactComponent
        { children :: Array JSX
        , next :: Effect Unit
        , hasMore :: Boolean
        , dataLength :: Int
        , loader :: JSX
        , endMessage :: JSX
        }
    )
mkInfiniteScroll = pure infiniteScroll
