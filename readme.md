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

# Run

You need a TLS certificate to run the program. This can be done with openssl, but I had some issues... You should just do 
```powershell
PS> openssl genrsa -out key.pem 2048 # create a private RSA key
PS> openssl req -new -key key.pem -out certificate.csr # generate a TLS certificate
PS> openssl x509 -req -in certificate.csr -signkey key.pem -out certificate.pem # sign the certificate
```

but I had a little issue. For me, it was
```powershell
PS> openssl genrsa -out key.pem 2048 # create a private RSA key
PS> openssl req -new -key key.pem -out certificate.csr # generate a TLS certificate
Can't open C:\Program Files\Common Files\ssl/openssl.cnf for reading, No such file or directory
14368:error:02001003:system library:fopen:No such process:crypto\bio\bss_file.c:69:fopen('C:\Program Files\Common Files\ssl/openssl.cnf','r')
14368:error:2006D080:BIO routines:BIO_new_file:no such file:crypto\bio\bss_file.c:76:
PS> get-command openssl | select -ExpandProperty Source # the last command failed, because it cannot find the ssl config. where is the openssl executable?
C:\Users\Ludvig\Miniconda3\Library\bin\openssl.exe
PS> openssl req -new -key key.pem -out certificate.csr -config C:\Users\Ludvig\Miniconda3\Library\ssl\openssl.cnf # the config path is specified manually. I found it, based on the openssl installation path above
PS> openssl x509 -req -in certificate.csr -signkey key.pem -out certificate.pem # sign the certificate
```

and then it worked. :)
