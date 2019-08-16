HSR[s_, sp_] := 
  Composition @@ (StringReplace[x : #[s] :> CaseAwarenessConvert[x, #[sp]], IgnoreCase -> True] & /@ {Identity, StringRiffle[Characters[#], "."] &});

CaseAwarenessConvert[s_, sp_] := Module[
   {fs, l, lsp = Characters@sp},
   fs = Which[UpperCaseQ[#], ToUpperCase, LowerCaseQ[#], ToLowerCase, True, Identity] & /@ Characters[s];
   l = If[Length@lsp > 1, Table[fs[[ 1 + Round[(Length@fs - 1) (n - 1)/(Length@lsp - 1)]]], {n, Length@lsp}], {First@fs}];
   StringJoin@MapThread[#1[#2] &, {l, lsp}]
   ];

(*Tests*)
f=HSR["windows","harmony"];
f@"windows 10 is the newest version"
f@"WindoWS 2000 is built on NT"
f@"WINdows is funny"
