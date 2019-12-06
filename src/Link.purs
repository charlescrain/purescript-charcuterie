module Link where

import Prelude
import Effect (Effect)
import Foreign (unsafeToForeign)
import React.Basic.DOM as R
import React.Basic.DOM.Events (preventDefault)
import React.Basic.Events (handler)
import React.Basic.Hooks (JSX, ReactComponent, component, fragment)
import Routing.PushState (PushStateInterface)

mkLink :: PushStateInterface -> Effect (ReactComponent { to :: String, content :: Array JSX })
mkLink { pushState } = do
  component "Link" \{ to, content } -> React.do
    pure
      $ fragment
          [ R.a
              { onClick:
                handler preventDefault
                  $ \_ -> do
                      pushState (unsafeToForeign {}) to
              , href: to
              , children: content
              }
          ]
