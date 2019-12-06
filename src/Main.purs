module Main where

import Prelude

import App (mkApp)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.DOM (render)
import React.Basic.Hooks (element)
import Routes (maybeAppRoutes, route)
import Routing.PushState (PushStateInterface, makeInterface, matches)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

main :: Effect Unit
main = do
  container <- getElementById "root" =<< (map toNonElementParentNode $ document =<< window)
  cfg@{nav} <- setup
  case container of
    Nothing -> throw "Root element not found."
    Just c -> do
      app <- mkApp cfg
      void $ nav
        # matches maybeAppRoutes \_ nr -> do
            content <- route nr
            let
              appJSX = element app { content }
            render appJSX c

setup :: Effect {nav :: PushStateInterface}
setup = do
  nav <- makeInterface
  pure {nav}