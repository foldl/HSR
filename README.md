# Harmony String Replacing Algorithm & Implementations

[简体中文版](README.zh.md).

Harmony String Replacing Algorithm (HSR in short) is a case-awareness string replacing algorithm.
HSR uses state-of-the-art machine learning technology & advanced abstract algebra to reconstruct
a replacement of the original string *preciously*, *beautifully*, and *elegantly*.

HSR is dedicated to solving the pain point of renaming things.

## Showcase

```Mathematica
f = HSR["windows","harmony"];
f @ "windows 10 is the newest version"
f @ "Windows 2000 is built on NT"
f @ "WINdows is funny"

(*Output*)
"Harmony 10 is the newest H.A.R.M.O.N.Y version"
"Harmony 2000 is built on NT"
"HARmony is funny"
```

## Reference Implementations

Reference implementations using difference languages are listed below in alphabetical order:

* [`Erlang`](hsr.erl)
* [`JavaScript`](hsr.js)
* [`Julia`](hsr.jl)
* [`Mathematica`](hsr.m)
* [`Python`](hsr.py)
* [`TypeScript`](hsr.ts)

All implementations have been verified using [formal methods](formal.v).