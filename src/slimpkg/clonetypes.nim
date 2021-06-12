import ./githubapi
import json
import streams
import os
import hnimast
import hnimast/pnode_parse
import hnimast/obj_field_macros
# import hpprint
import macros
import compiler /
  [idents, options, modulegraphs, passes, lineinfos, sem, pathutils, ast,
    modules, condsyms, passaux, llstream, parser, nimblecmd, scriptconfig,
    passes
  ]

const dir = currentSourcePath.parentDir
const nimbleDir = dir / "nimble"

template copyNimble(client: GithubApiClient; path: string; ) =
  let res = client.getRawFile("nim-lang", "nimble", path)
  var c = res.bodyStream.readAll()
  writeFile(nimbleDir / extractFilename(path), c)

template copyNimble(client: GithubApiClient; path: string; cond: untyped) =
  let res = client.getRawFile("nim-lang", "nimble", path)
  var c = res.bodyStream.readAll()
  let n = c.parsePNodeStr()
  c = ""
  for it {.inject.} in n.sons:
    if cond:
      c = c & $(it.toNimDecl())
      break
  writeFile(nimbleDir / extractFilename(path), c)

when isMainModule:
  var client = newGithubApiClient()
  # let res = client.getRepo("nim-lang","nimble")
  # echo parseJson(res.bodyStream.readAll())
  if not dirExists(nimbleDir):
    createDir(nimbleDir)

  client.copyNimble("src/nimblepkg/common.nim")
  client.copyNimble("src/nimblepkg/packageinfo.nim", it.kind == nkTypeSection)
  client.copyNimble("src/nimblepkg/version.nim")
