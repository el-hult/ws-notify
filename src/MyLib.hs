module MyLib (mainPage) where

import qualified Data.Text as T
import qualified Data.Text.IO (readFile)
import Paths_WS_Notify (getDataFileName)

mainPage :: IO T.Text
mainPage = getDataFileName "static/main.html" >>= Data.Text.IO.readFile
