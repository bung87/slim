import os
import hnimast/compiler_aux
# import slimpkg/submodule

when isMainModule:
  let p = currentSourcePath.parentDir.parentDir / "slim.nimble"
  echo p
  let c = readFile(p)
  echo parsePackageInfoNims(c)
