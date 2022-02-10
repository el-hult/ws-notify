-- | https://stackoverflow.com/questions/23395590/concurrent-file-reads-writes-in-haskell
module SharedHandle (SharedHandle(), newSharedHandle, withSharedHandle) where

import Control.Concurrent.MVar
import System.IO              

data SharedHandle = SharedHandle Handle (MVar ())

newSharedHandle :: IO Handle -> IO SharedHandle
newSharedHandle makeHandle = do
    handle <- makeHandle
    lock <- newMVar()
    return $ SharedHandle handle lock

withSharedHandle :: SharedHandle -> (Handle -> IO a) -> IO a
withSharedHandle (SharedHandle handle lock) operation = do
    () <- takeMVar lock
    val <- operation handle
    putMVar lock ()
    return val