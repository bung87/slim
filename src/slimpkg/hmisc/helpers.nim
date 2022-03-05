import macros, strutils

import algo/[halgorithm, hseq_mapping]
export halgorithm
export hseq_mapping
import sequtils
# import hdebug_misc
# export hdebug_misc
import strformat
import strutils
export strutils

import base_errors
export base_errors

template subnodesEq*(lhs, rhs, field: untyped): untyped =
  ## Check if two objects `lhs` and `rhs` has identical field `field`
  ## by comparing all items in the field. Check if two object's fields
  ## have identical lengths too.
  lhs.field.len() == rhs.field.len() and
  zip(lhs.field, rhs.field).allOfIt(it[0] == it[1])

template fail*(msg: string): untyped =
  debugecho "Fail on ", instantiationInfo()
  raiseAssert(msg)

template nnil*(): untyped =
  defer:
    let iinfo = instantiationInfo()
    when result is seq:
      for idx, val in result:
        when val is ref:
          assert (val != nil)
        else:
          for name, fld in val.fieldPairs():
            when fld is ref:
              if fld.isNil:
                raiseAssert("Non-nil return assert on line " &
                  $iinfo.line & ". Error idx: " & $idx & " fld name: " &
                  name & ". Item type is " & $typeof(val)
                )
    else:
      assert (result != nil)


type
  SingleIt*[T] = object
    it: seq[T]

func getIt*[T](it: SingleIt[T]): T = it.it[0]
func setIt*[T](it: var SingleIt[T], val: T): void = (it.it[0] = val)
func getIt*[T](it: var SingleIt[T]): var T = it.it[0]
func newIt*[T](it: T): SingleIt[T] = SingleIt[T](it: @[it])
converter toT*[T](it: SingleIt[T]): T = it.it[0]

func takesOnlyMutable*[T](v: var T) = discard
template isMutable*(v: typed): untyped = compiles(takesOnlyMutable(v))

macro dumpStr*(body: untyped): untyped =
  newCall(ident "echo", newLit(body.treeRepr()))

template notNil*(arg: untyped): bool = not isNil(arg)

func nor*(args: varargs[bool]): bool =
  for arg in args:
    result = arg or result

  result = not result

func nand*(args: varargs[bool]): bool =
  result = true
  for arg in args:
    result = arg and result

  result = not result

func `or`*(args: varargs[bool]): bool =
  for arg in args:
    result = arg and result

func `and`*(args: varargs[bool]): bool =
  result = true
  for arg in args:
    result = arg and result

{.push inline.}

func `-`*[E](s1: set[E], s2: E): set[E] = s1 - {s2}
func `-=`*[E](s1: var set[E], v: E | set[E]) = (s1 = s1 - {v})

{.pop.}

import std/[options, times]

proc add*[T](s: var seq[T], opt: Option[T]) =
  if opt.isSome():
    s.add opt.get()

proc `&`*[T](elements: openarray[seq[T]]): seq[T] =
  for element in elements:
    result &= element

proc `&`*(strings: openarray[string]): string =
  for str in strings:
    result &= str

proc `&=`*(target: var string, args: openarray[string]) =
  for arg in args:
    target &= arg

template timeIt*(name: string, body: untyped): untyped =
  block:
    let start = cpuTime()
    body
    let total {.inject.} = cpuTime() - start
    echo &"  {total:<5} ms ", name

proc toString*(x: enum): string {.magic: "EnumToStr", noSideEffect.}
