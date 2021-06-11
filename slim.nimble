# Package

version       = "0.1.0"
author        = "bung87"
description   = "nim package manager"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["slim"]


# Dependencies

requires "nim >= 1.5.1"
requires "hnimast"
