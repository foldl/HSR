-module(hsr).

-export([hsr/2]).
-export([test/0]).

-import(lists, [flatten/1, split/2]).

hsr(S, SP) when is_list(S), is_list(SP) ->
    L = [fun (Str) -> hsr(F(S), F(SP), Str) end || F <- [fun (X) -> X end, fun (X) -> string:join([[C] || C <- X], ".") end]],
    fun (X) -> lists:foldl(fun (F, Acc) -> F(Acc) end, X, L) end.

hsr(S, SP, Orig) -> hsr(string:casefold(S), string:casefold(Orig), SP, Orig, []).

hsr(LS, LO, SP, Orig, Acc) ->
    case string:find(LO, LS) of
        nomatch -> flatten(lists:reverse([Orig | Acc]));
        Match ->
            {S0, Rem} = split(length(Orig) - length(Match), Orig),
            {S1, OrigRem} = split(length(LS), Rem),
            hsr(LS, Rem, SP, OrigRem, [caseawarenessconvert(S1, SP), S0 | Acc])
    end.

caseawarenessconvert(S, SP) ->
    Fs = [get_f(C) || C <- S],
    L = case length(SP) of
        1 -> [1];
        _ -> [1 + round((length(Fs) - 1) * N / (length(SP) - 1)) || N <- lists:seq(0, length(SP) - 1)]
        end,
    flatten(lists:zipwith(fun (N, C) -> F = lists:nth(N, Fs), F([C]) end, L, SP)).

get_f(C) ->
    S = [C],
    case {S =:= string:uppercase(S), S =:= string:lowercase(S)} of
        {true, false} -> fun string:uppercase/1;
        {false, true} -> fun string:lowercase/1;
        _  -> fun (X) -> X end
    end.

test() ->
    F = hsr("windows", "harmony"),
    io:format("~ts~n", [F("Windows 10 is the newest W.I.N.D.O.W.S version")]),
    io:format("~ts~n", [F("WindoWS 2000 is built on NT")]),
    io:format("~ts~n", [F("WINdows is funny")]).
