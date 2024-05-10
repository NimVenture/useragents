import std/[os, streams, json, sequtils]

type UserAgent = ref object
  useragent: string
  percent: float
  `type`: string
  system: string
  browser: string
  version: float
  os: string

proc readUseragents*(): seq[UserAgent] =
  let path = currentSourcePath.parentDir / "useragen" / "data" / "browsers.json"
  var strm = newFileStream(path, fmRead)
  var line = ""

  if not isNil(strm):
    while strm.readLine(line):
      if line.len > 0:
        result.add line.parseJson.to(UserAgent)
    strm.close()

when isMainModule:

  let uas = readUseragents()
  echo repr uas.filterIt(it.browser == "chrome" and it.`type` == "pc" and it.os == "win10")
  echo repr uas.filterIt(it.browser == "chrome" and it.`type` == "pc" and it.os == "linux")
  echo repr uas.filterIt(it.browser == "chrome" and it.`type` == "pc" and it.os == "macos")
  