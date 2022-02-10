module Main where

import qualified HTTPServer
import qualified WSServer
import Control.Concurrent (forkIO)
import Control.Monad (void)

main :: IO ()
main = do
  putStrLn "Starting main"
  _ <- forkIO HTTPServer.main
  void WSServer.main