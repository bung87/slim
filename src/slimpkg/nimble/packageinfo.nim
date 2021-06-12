type
  Package* = object ## Definition of package from packages.json.
    name*: string
    url*: string
    license*: string
    downloadMethod*: string
    description*: string
    tags*: seq[string]
    version*: string
    dvcsTag*: string
    web*: string
    alias*: string  ## A name of another package, that this package aliases.

  MetaData* = object
    url*: string

  NimbleLink* = object
    nimbleFilePath*: string
    packageDir*: string
