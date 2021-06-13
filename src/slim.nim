import os
import slimpkg/hnimast/nimble_helper
# import slimpkg/submodule
import sets, tables

when isMainModule:
  let p = currentSourcePath.parentDir.parentDir / "slim.nimble"
  echo p
  let c = readFile(p)
  let info = parsePackageInfo(c)
  echo "tasks:", $info.nimbleTasks
  echo "requires:", $info.requires
  echo "taskDeps:", $info.taskDeps
  echo "preDeps:", $info.preDeps
