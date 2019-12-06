module App where

import Prelude

import Effect (Effect)
import Link (mkLink)
import Nav (mkNavComponent)
import React.Basic.Hooks (JSX, ReactComponent, component, element, fragment)
import Routing.PushState (PushStateInterface)

mkApp :: forall r. {nav :: PushStateInterface | r} -> Effect (ReactComponent {content :: Array JSX})
mkApp cfg@{nav} = do
  link <- mkLink nav
  navComponent <- mkNavComponent cfg
  component "App" \{content} -> React.do
    pure
      $ fragment
          [ 
           element navComponent {content}
          ]
