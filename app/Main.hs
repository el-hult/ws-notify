module Main where

import qualified HTTPServer
import qualified WSServer
import Control.Concurrent (forkIO)
import Control.Monad (void)
import SharedHandle (newSharedHandle)
import System.IO (stdout)

main :: IO ()
main = do
  putStrLn "Starting main"
  sharedStdOut <- newSharedHandle $ return stdout
  _ <- forkIO  $ HTTPServer.main sharedStdOut
  void $ WSServer.main sharedStdOut