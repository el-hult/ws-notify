
{-# LANGUAGE OverloadedStrings #-}
module WSServer where
import Control.Exception (finally)
import Control.Monad (forever)
import Control.Concurrent (threadDelay)
import qualified Data.Text as T
import qualified Network.WebSockets as WS
import SharedHandle ( SharedHandle, withSharedHandle )
import System.IO ( hPutStrLn )

main :: SharedHandle -> IO ()
main sharedStdOut = do
  withSharedHandle sharedStdOut $ \h -> hPutStrLn h "Starting the WebSocket server at port 9160!"
  WS.runServer "127.0.0.1" 9160 application

application :: WS.ServerApp
application pending = do
    conn <- WS.acceptRequest pending
    WS.withPingThread conn 30 (return ()) $ do
        finally (talk conn) disconnect
        

disconnect :: IO ()                
disconnect = putStrLn "A user disconnected"

talk :: WS.Connection -> IO ()
talk conn = forever $ do
    msg <- WS.receiveData conn
    threadDelay 1000000 --sleep for a million microseconds, or one second
    WS.sendTextData conn $ (T.pack "You told me: ") <> msg
