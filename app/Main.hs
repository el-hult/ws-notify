{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.Trans
import Data.IORef
import MyLib (mainPage)
import Web.Spock
import Web.Spock.Config

data MySession = EmptySession

newtype MyAppState = DummyAppState (IORef Int)

main :: IO ()
main =
  do
    ref <- newIORef 0
    spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
    runSpock 8080 (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app = get root $ liftIO mainPage >>= html
