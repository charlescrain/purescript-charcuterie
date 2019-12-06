module Page.Activity where

import Prelude

import Data.Array (length, range)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), maybe)
import Effect (Effect)
import Effect.Aff (Aff, Milliseconds(..), delay, runAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Exception (throw)
import React.Basic (JSX, ReactComponent, element, fragment)
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks (component, useReducer, (/\))
import React.Basic.Hooks as React
import React.Basic.Hooks.Aff (useAff)
import React.InfiniteScroll (infiniteScroll)
import React.MD.Button (button)

data Action = UpdateItems {items :: Array JSX, hasMore :: Boolean}

mkActivity :: Effect (ReactComponent {})
mkActivity =
  component "Activity" \props -> React.do
    state /\ dispatch <-
      useReducer { items: [], hasMore: true } \state -> case _ of
        UpdateItems {items: newItems, hasMore}  -> state { items = state.items <> newItems, hasMore = hasMore }
    useAff "initialQuery" do
      items <- getMore 40 1
      liftEffect $ dispatch $ (UpdateItems items)
    pure $ element infiniteScroll 
      { children: state.items
      , dataLength: length state.items
      , endMessage: R.div_ [ R.text "Kooooook you done"]
      , hasMore: state.hasMore
      , loader: R.div_ [ R.text "Loading..."]
      , next: runAff_ (
          case _ of
            Left err -> throw $ show err
            Right items -> dispatch $ UpdateItems items
        ) (getMore 40 $ length state.items + 1)
      }

getMore :: Int -> Int -> Aff {items :: Array JSX, hasMore :: Boolean}
getMore amount nextCursor = do
  delay (Milliseconds 2000.0)
  let items = map
        (\i -> R.div_ 
            [ element button
                { children: [ R.text ("md baby: " <> show i) ]
                , disabled: false
                , onClick: handler_ $ log"hi"
                , raised: true
                }
            ]
        ) 
        (range nextCursor (nextCursor + amount))
  pure {items, hasMore: nextCursor + amount < 100}
