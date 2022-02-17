{-# LANGUAGE OverloadedStrings #-}

module HTTPServer where

import Control.Monad.Trans
import MyLib (mainPage)
import Web.Spock
import Web.Spock.Config
import SharedHandle
import System.IO
import Network.Wai.Handler.WarpTLS
import Network.Wai.Handler.Warp

data MySession = EmptySession

newtype MyAppState = MyAppState ()

newState :: MyAppState
newState = MyAppState ()

main :: SharedHandle  -> IO ()
main sharedStdOut = do
    withSharedHandle sharedStdOut $ \h -> hPutStrLn h "Starting the HTTP      server at port 8080!"
    spockCfg <- defaultSpockCfg EmptySession PCNoDatabase newState
    waiApp <- spockAsApp (spock spockCfg spockMApp)
    runTLS defaultTlsSettings (setPort 8080 defaultSettings) waiApp

spockMApp :: SpockM () MySession MyAppState ()
spockMApp = get root $ liftIO mainPage >>= html
