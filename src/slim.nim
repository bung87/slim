import os
import slimpkg/hnimast/nimble_helper
# import slimpkg/submodule
import sets, tables

const cc = """
# Package

version       = "1.0.17"
author        = "bung87"
description   = "micro and elegant web framework"
license       = "Apache License 2.0"
srcDir        = "src"
skipDirs      = @["tests","examples","experiments","benchmark"]

# Dependencies

requires "nim >= 1.3.1"
requires "chronos >= 3.0.2" # initial 2.6.1
requires "npeg"
requires "zippy"
requires "jsony"
requires "result"

# requires "asynctest >= 0.2.0 & < 0.3.0"
# task test, "Runs the test suite":
  # exec "testament --megatest:off pattern 'tests/*.nim'"

task docs,"a":
  exec "nim doc --project src/scorper.nim"

task ghpage,"gh page":
  cd "src/htmldocs" 
  exec "git init"
  exec "git add ."
  exec "git config user.name \"bung87\""
  exec "git config user.email \"crc32@qq.com\""
  exec "git commit -m \"docs(docs): update gh-pages\""
  let url = "\"https://bung87@github.com/bung87/scorper.git\""
  exec "git push --force --quiet " & url & " master:gh-pages"

task benchmark,"benchmark":
  requires "jester"
  exec "nim c -r -d:release --threads:on -d:port=8888 benchmark/benchmark.nim"
  exec "nim c -r -d:release --threads:on -d:port=9999 -d:demoPath=benchmark/tjester.nim benchmark/benchmark.nim"

task benchmarkserver,"benchmarkserver":
  exec "nim c -r -d:release --threads:on -d:port=7777 -d:serverTest -d:demoPath=examples/hello_world.nim benchmark/benchmark.nim"
  exec "nim c -r -d:release --threads:on -d:port=6666 -d:serverTest -d:demoPath=benchmark/tstdserver.nim benchmark/benchmark.nim"

task benchmarkresp,"benchmarkresp":
  requires "prologue"
  exec "nim c -r -d:release --threads:on -d:port=7777 -d:demoPath=benchmark/simple_resp.nim benchmark/benchmark_resp.nim"
  exec "nim c -r -d:release --threads:on -d:port=6666 -d:demoPath=benchmark/simple_resp_prologue.nim benchmark/benchmark_resp.nim"

task benchmarkresp2,"benchmarkresp2":
  requires "httpbeast"
  exec "nim c -r -d:release --threads:on -d:port=7777 -d:demoPath=benchmark/simple_resp.nim benchmark/benchmark_resp.nim"
  exec "nim c -r -d:release --threads:on -d:port=6666 -d:demoPath=benchmark/simple_resp_httpbeast.nim benchmark/benchmark_resp.nim"

task strict, "stric async exception check":
  exec "nimble test -d:chronosStrictException"

before test:
  requires "asynctest >= 0.2.0 & < 0.3.0"

"""

when isMainModule:
  # let p = currentSourcePath.parentDir.parentDir / "slim.nimble"
  # echo p
  # let c = readFile(p)
  let info = parsePackageInfo(cc)
  echo "tasks:", $info.nimbleTasks
  echo "requires:", $info.requires
  echo "taskDeps:", $info.taskDeps
  echo "preDeps:", $info.preDeps
