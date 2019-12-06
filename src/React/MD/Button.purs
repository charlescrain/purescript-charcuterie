module React.MD.Button where

import Prelude
import Data.Maybe (Maybe)
import Effect (Effect)
import React.Basic (JSX, ReactComponent)
import React.Basic.Events (EventHandler)

foreign import button ::
  ReactComponent
    { children :: Array JSX
    , onClick :: EventHandler
    , disabled :: Boolean
    , raised :: Boolean
    }

mkButton ::
  Effect
    ( ReactComponent
        { children :: Array JSX
        , onClick :: EventHandler
        , disabled :: Boolean
        , raised :: Boolean
        }
    )
mkButton = pure button
