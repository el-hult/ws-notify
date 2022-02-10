# WS-NOTIFY

A web server that serves a simple home page. It connects back with javascript to the server via websockets.
Then the server sends push notifications via the socket at random intervals.

In practice, the server is a Spock HTTP server that provides the home page at localhost:8080, and a websocket server
provided via the websockets package, listening at port 9160. They work in separate threads in the same process.

## Develop

Compilation
`cabal build`

Running
`cabal run`

Use the `Haskell Language Server` to get some development aid from HLint and Ormolu. If you want to use them separately, do the below...

Use ormolu as the autoformatter. It cannot traverse directories itself, so You must use some powershell helper to traverse. :)
Or you just let HSL do that via your IDE. See below as a suggestion.
```
cabal install ormolu
gci -Recurse *.hs | ?{ $_.FullName -notlike '*dist-newstyle*'} | %{ C:\cabal\bin\ormolu.exe --mode inplace --cabal-default-extensions $_}
```

For HLint, you can select option `--git` to make it ignore things that are git-ignored. :)
```
cabal install hlint
C:\cabal\bin\hlint.exe --git .
```