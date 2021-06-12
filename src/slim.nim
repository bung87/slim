import os
import slimpkg/hnimast/nimble_helper
# import slimpkg/submodule
import sets,tables

when isMainModule:
  let p = currentSourcePath.parentDir.parentDir / "slim.nimble"
  echo p
  let c = readFile(p)
  let info = parsePackageInfo(c)
  echo $info.nimbleTasks
  echo $info.requires
  echo $info.taskDeps
