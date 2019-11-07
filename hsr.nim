import strutils, sugar, sequtils, math

func caseawarenessconvert(s, sp: string): string =
  let fs = s.map(func (c: char): (proc (c: char): char {.noSideEffect.}) = 
    if isLowerAscii(c): (func (d: char): char = d.toLowerAscii)
    elif isUpperAscii(c): (func (d: char): char = d.toUpperAscii)
    else: (func (d: char): char = d))
  let l = if sp.len > 0: toSeq(0..sp.high).mapIt(toInt round ((s.len - 1) * it / (sp.len - 1))) else: @[0]
  return zip(l, sp).map((it) => (let (i, c) = it; fs[i](c))).join

func hsr0(s, sp, origin: string): string =
  let ls = s.toLower
  var a: SkipTable
  var start: Natural = 0
  initSkipTable(a, ls)
  while true:
    let pos = find(a, origin.toLower, ls, start)
    if pos < 0: break
    result &= origin[start..pos - 1] & caseawarenessconvert(origin[pos..pos + ls.len - 1], sp)
    start = pos + ls.len

  result &= origin[start..origin.high]

func hsr*(s, sp: string): (proc (s: string): string {.noSideEffect.}) = 
  let m = @[func (x: string): string = x, func (x: string): string = x.toSeq.join(".")]
  return func (x: string): string = m.map((it) => func (x: string): string = hsr0(it(s), it(sp), x)).foldl(b(a), x)

static:
  let f = hsr("windows", "harmony")
  echo f "Windows 10 is the newest W.I.N.D.O.W.S version"
  echo f "WindoWS 2000 is built on NT"
  echo f "WINdows is funny"