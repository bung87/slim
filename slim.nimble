# Package

version       = "0.1.6"
author        = "bung87"
description   = "nim package manager"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
namedBin = {"slimpkg/nimble/nimble":"slim" }.toTable()



# Dependencies

requires "nim >= 1.4.0"
requires "hmisc = 0.12.4"
requires "compiler"

when defined(nimdistros):
  import distros
  if detectOs(Ubuntu):
    foreignDep "libssl-dev"
  else:
    foreignDep "openssl"

task atask, "des":
  requires "asynctest"
# before atask:
#   echo "before atask"
#   requires "a"
#   echo "end atask requires"  
before test:
  requires "asynctest"

