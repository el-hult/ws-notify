# WS-NOTIFY

as web server that server a simple home page. It connects back with javascript to the server via websockets.
Then the server sends push notifications via the socket at random intervals.

at least, this is the goal I'm aiming for.


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

For HLint, you can select option `--git` to make it ignore things that are git0ignored. :)
```
cabal install hlint
C:\cabal\bin\hlint.exe --git .
```