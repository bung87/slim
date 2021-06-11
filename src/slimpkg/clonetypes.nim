import ./githubapi
import json
import streams

when isMainModule:
  var client = newGithubApiClient()
  let res = client.getRepo("nim-lang","nimble")
  echo parseJson(res.bodyStream.readAll())