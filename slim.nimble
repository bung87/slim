# Package

version       = "0.1.5"
author        = "bung87"
description   = "nim package manager"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
namedBin = {"slimpkg/nimble/nimble":"slim" }.toTable()



# Dependencies

requires "nim >= 1.4.0"
requires "hmisc"
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
task test,"overwrites test":
  echo "custom test"
before test:
  requires "asynctest"

