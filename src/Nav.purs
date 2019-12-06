module Nav where

import Prelude
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Link (mkLink)
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks (JSX, ReactComponent, component, element)
import React.MD.Button (mkButton)
import Routing.PushState (PushStateInterface)
import Web.HTML.HTMLBaseElement (href)
import Web.HTML.HTMLButtonElement (disabled)

mkNavComponent :: forall r. { nav :: PushStateInterface | r } -> Effect (ReactComponent { content :: Array JSX })
mkNavComponent { nav } = do
  link <- mkLink nav
  button <- mkButton
  liftEffect
    $ component "Nav" \{ content } -> React.do
        pure $ R.div_
          $ [ element link { to: "/", content: [ R.text "Home" ] }
            , element link { to: "/activity", content: [ R.text "Activity" ] }
            , element button
                { children: [ R.text "md baby!" ]
                , disabled: false
                , onClick: handler_ $ log "hi"
                , raised: true
                }
            ]
          <> content
