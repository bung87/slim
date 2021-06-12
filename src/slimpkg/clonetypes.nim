import ./githubapi
import json
import streams
import os
import hnimast
import hnimast/pnode_parse
# import hnimast/obj_field_macros
# import hpprint
import macros
import compiler /
  [idents, options, modulegraphs, passes, lineinfos, sem, pathutils, ast,
    modules, condsyms, passaux, llstream, parser, nimblecmd, scriptconfig,
    passes
  ]

const dir = currentSourcePath.parentDir
const nimbleDir = dir / "nimble"
const hnimastDir = dir / "hnimast"

template copyNimble(client: GithubApiClient; path: string; ) =
  let res = client.getRawFile("nim-lang", "nimble", path)
  var c = res.bodyStream.readAll()
  writeFile(nimbleDir / extractFilename(path), c)

template copyNimble(client: GithubApiClient; path: string; prepend = ""; cond: untyped) =
  let res = client.getRawFile("nim-lang", "nimble", path)
  var c = res.bodyStream.readAll()
  let n = c.parsePNodeStr()
  c = prepend
  for it {.inject.} in n.sons:
    var vali = false
    try:
      vali = cond
    except:
      discard
    if vali:
      c = c & $(it.toNimDecl()) & "\n"

  writeFile(nimbleDir / extractFilename(path), c)

template copyHnimast(client: GithubApiClient; path: string; ) =
  let res = client.getRawFile("haxscramper", "hnimast", path)
  var c = res.bodyStream.readAll()
  writeFile(hnimastDir / extractFilename(path), c)

template copyHnimast(client: GithubApiClient; path: string; cond: untyped) =
  let res = client.getRawFile("haxscramper", "hnimast", path)
  var c = res.bodyStream.readAll()
  let n = c.parsePNodeStr()
  c = ""
  for it {.inject.} in n.sons:
    if cond:
      c = c & $(it.toNimDecl()) & "\n"
      break
  writeFile(hnimastDir / extractFilename(path), c)

when isMainModule:
  var client = newGithubApiClient()
  # let res = client.getRepo("nim-lang","nimble")
  # echo parseJson(res.bodyStream.readAll())
  if not dirExists(nimbleDir):
    createDir(nimbleDir)

  if not dirExists(nimbleDir):
    createDir(nimbleDir)

  # client.copyNimble("src/nimblepkg/common.nim")
  let prepend = """
import common,os,sets,tables,strutils,json
import ./options
import ./version
import ./cli
import ./config
import ./tools
import httpclient
from net import SslError
"""
  const imps = [nkImportExceptStmt, nkImportStmt, nkFromStmt, nkImportStmt]
  # nkTypeSection or (it.kind == nkProcDef and $(it[0][^1]) in ["initPackageInfo","getInstalledPkgsMin","findNimbleFile","readNimbleLink","readMetaData","getNameVersion","resolveAlias","getPackageList","readPackageList"]
  # client.copyNimble("src/nimblepkg/packageinfo.nim",prepend, it.kind notin imps )
  # client.copyNimble("src/nimblepkg/packageinfo.nim")
  # client.copyNimble("src/nimblepkg/version.nim")
  # client.copyHnimast("src/hnimast/hast_common.nim")
  # client.copyNimble("src/nimblepkg/packageparser.nim")
  # client.copyNimble("src/nimblepkg/cli.nim")
  # client.copyNimble("src/nimblepkg/options.nim")
  # client.copyNimble("src/nimblepkg/config.nim")
  # client.copyNimble("src/nimblepkg/tools.nim")
  client.copyNimble("src/nimblepkg/download.nim")
  client.copyNimble("src/nimblepkg/packageinstaller.nim")
  client.copyNimble("src/nimblepkg/publish.nim")
  client.copyNimble("src/nimblepkg/nimscriptexecutor.nim")
  client.copyNimble("src/nimblepkg/nimscriptwrapper.nim")
  client.copyNimble("src/nimblepkg/reversedeps.nim")
  client.copyNimble("src/nimblepkg/init.nim")


