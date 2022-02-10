
{-# LANGUAGE OverloadedStrings #-}
module WSServer where
import Control.Exception (finally)
import Control.Monad (forever)
import Control.Concurrent (threadDelay)
import qualified Data.Text as T
import qualified Network.WebSockets as WS
import SharedHandle ( SharedHandle, withSharedHandle )
import System.IO ( hPutStrLn )
import System.Random (randomRIO)

main :: SharedHandle -> IO ()
main sharedStdOut = do
  withSharedHandle sharedStdOut $ \h -> hPutStrLn h "Starting the WebSocket server at port 9160!"
  WS.runServer "127.0.0.1" 9160 application

application :: WS.ServerApp
application pending = do
    conn <- WS.acceptRequest pending
    WS.withPingThread conn 30 (return ()) $ do
        finally (sendHelloRepeat conn) disconnect


disconnect :: IO ()
disconnect = putStrLn "A user disconnected"

sendHelloRepeat :: WS.Connection -> IO ()
sendHelloRepeat conn = forever $ do
    delay <- randomRIO (1*1000*1000,5*1000*1000) -- between 1 and 5 million microseconds = 0.5 to 1 second
    threadDelay delay
    WS.sendTextData conn $ T.pack "Hello?!"
