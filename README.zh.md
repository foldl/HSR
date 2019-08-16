# “好蒙你”字符串替换算法及其实现

[English version](README.md).

“好蒙你”字符串替换算法（Harmony String Replacing Algorithm，简称 HSR）是一种可以感知大小写的字符串替换算法。
HSR 使用目前最先进的机器学习技术和高等抽象代数为原始字符串数构造替代串，*精准*，*漂亮*，*优美*。

HSR 致力于解决为事物重新命名这一痛点。

## 演示

```Mathematica
蒙之 = HSR["windows","harmony"];
蒙之 @ "windows 10 is the newest version"
蒙之 @ "Windows 2000 is built on NT"
蒙之 @ "WINdows is funny"

(*Output*)
"Harmony 10 is the newest H.A.R.M.O.N.Y version"
"Harmony 2000 is built on NT"
"HARmony is funny"
```

## 参考实现

提供基于以下多种编程语言（按字母表顺序排列）的参考实现：

* [`Erlang`](hsr.erl)
* [`JavaScript`](hsr.js)
* [`Julia`](hsr.jl)
* [`Mathematica`](hsr.m)
* [`Python`](hsr.py)
* [`TypeScript`](hsr.ts)

所有实现皆已经过[形式化方法](formal.v)验证。