module Main where

import Args
  ( AddOptions (..),
    Args (..),
    GetOptions (..),
    SearchOptions (..),
    parseArgs,
  )
import qualified Data.List as L
import qualified Entry.DB as DB
import Entry.Entry
  ( Entry (..),
    FmtEntry (FmtEntry),
    matchedByAllQueries,
    matchedByQuery,
  )
import Result
import System.Environment (getArgs)
import Test.SimpleTest.Mock
import Prelude hiding (print, putStrLn, readFile)
import qualified Prelude

usageMsg :: String
usageMsg =
  L.intercalate
    "\n"
    [ "snip - code snippet manager",
      "Usage: ",
      "snip add <filename> lang [description] [..tags]",
      "snip search [code:term] [desc:term] [tag:term] [lang:term]",
      "snip get <id>",
      "snip init"
    ]

-- | Handle the init command
handleInit :: TestableMonadIO m => m ()
-- handleInit = return ()
handleInit = do
  let nouaBazaDeDate = DB.empty
  DB.save nouaBazaDeDate
  return()

-- | Handle the get command
handleGet :: TestableMonadIO m => GetOptions -> m ()
handleGet getOpts = 
  do
    loadedDB <- DB.load
    case loadedDB of
      (Error err) ->
        putStrLn "Failed to load DB"
      (Success db) ->
        case foundEntry of
          Nothing ->
            putStrLn "No entry was found"
          Just entry ->
            putStrLn (entrySnippet entry)
        where
          foundEntry = DB.findFirst (\entry -> entryId entry == getOptId getOpts) db

getEntryIdAndFileName :: Entry -> String
getEntryIdAndFileName entry = head $ lines $ show (FmtEntry entry)

-- | Handle the search command
handleSearch :: TestableMonadIO m => SearchOptions -> m ()
handleSearch searchOpts = 
  do
    loadedDb <- DB.load
    case loadedDb of
      (Error err) ->
        putStrLn "Failed to load DB"
      (Success db) ->
        case foundEntries of
            [] -> putStrLn "No entries found"
            _ -> putStrLn $ (unlines . L.map getEntryIdAndFileName) foundEntries
        where 
          foundEntries = DB.findAll (matchedByAllQueries (searchOptTerms searchOpts)) db

handleAdd :: (TestableMonadIO m) => AddOptions -> m ()
handleAdd addOpts = do
  snip <- readFile (addOptFilename addOpts)
  db <- DB.load
  case db of
    Error err -> putStrLn "Failed to load DB"
    Success dbGood -> do
      let -- check if the snippet is already in the db
          result = DB.findFirst (\e -> entrySnippet e == snip) dbGood
      case result of
        Just entry -> do
          let msg = "Entry with this content already exists: "
              entryDetail = head $ lines $ show $ FmtEntry entry
          putStrLn msg
          putStrLn entryDetail
          return ()
        Nothing -> do
          let db' = DB.insertWith (\id -> makeEntry id snip addOpts) dbGood
          DB.save db'
          return ()
  return ()
  where
    makeEntry :: Int -> String -> AddOptions -> Entry
    makeEntry id snippet addOpts =
      Entry
        { entryId = id,
          entrySnippet = snippet,
          entryFilename = addOptFilename addOpts,
          entryLanguage = addOptLanguage addOpts,
          entryDescription = addOptDescription addOpts,
          entryTags = addOptTags addOpts
        }

-- | Dispatch the handler for each command
run :: TestableMonadIO m => Args -> m ()
run (Add addOpts) = handleAdd addOpts
run (Search searchOpts) = handleSearch searchOpts
run (Get getOpts) = handleGet getOpts
run Init = handleInit
run Help = putStrLn usageMsg

main :: IO ()
main = do
  args <- getArgs
  let parsed = parseArgs args
  case parsed of
    (Error err) -> Prelude.putStrLn usageMsg
    (Success args) -> run args
