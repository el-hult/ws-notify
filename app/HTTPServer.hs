{-# LANGUAGE OverloadedStrings #-}

module HTTPServer where

import Control.Monad.Trans
import MyLib (mainPage)
import Web.Spock
import Web.Spock.Config
import SharedHandle
import System.IO

data MySession = EmptySession

newtype MyAppState = MyAppState ()

newState :: MyAppState
newState = MyAppState ()

main :: SharedHandle  -> IO ()
main sharedStdOut = do
    withSharedHandle sharedStdOut $ \h -> hPutStrLn h "Starting the HTTP      server at port 8080!"
    spockCfg <- defaultSpockCfg EmptySession PCNoDatabase newState
    runSpockNoBanner 8080 (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app = get root $ liftIO mainPage >>= html
