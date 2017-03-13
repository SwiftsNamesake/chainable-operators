{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_chained_operators (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\chained-operators\\.stack-work\\install\\68c2458c\\bin"
libdir     = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\chained-operators\\.stack-work\\install\\68c2458c\\lib\\x86_64-windows-ghc-8.0.1\\chained-operators-0.1.0.0-GkBvuZfGoz5312Kp8mtkpo"
dynlibdir  = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\chained-operators\\.stack-work\\install\\68c2458c\\lib\\x86_64-windows-ghc-8.0.1"
datadir    = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\chained-operators\\.stack-work\\install\\68c2458c\\share\\x86_64-windows-ghc-8.0.1\\chained-operators-0.1.0.0"
libexecdir = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\chained-operators\\.stack-work\\install\\68c2458c\\libexec"
sysconfdir = "C:\\Users\\Jonatan\\Desktop\\Haskell\\modules\\chained-operators\\.stack-work\\install\\68c2458c\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "chained_operators_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "chained_operators_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "chained_operators_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "chained_operators_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "chained_operators_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "chained_operators_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
