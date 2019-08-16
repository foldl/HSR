hsr(s :: AbstractString, sp :: AbstractString) = ∘((f -> make(f.([s, sp])...)).([identity, (s) -> join(collect(s), '.')])...)

make(s :: AbstractString, sp :: AbstractString) = (x) -> hsr0(s, sp, x)

function hsr0(s :: AbstractString, sp :: AbstractString, orig :: AbstractString) 
    i = 1
    r = ""
    lo = lowercase(orig)
    ls = lowercase(s)
    while true 
        p = findnext(ls, lo, i) 
        if p === nothing
            break
        end
        if p.start > i
            r *= orig[i:p.start-1]         
        end
        i = p.stop + 1
        r *= caseawarenessconvert(orig[p], sp)
    end
    if i <= length(orig)
        r *= orig[i:end]
    end
    return r
end

function caseawarenessconvert(s :: AbstractString, sp :: AbstractString)
    fs = ((c) -> if islowercase(c)
                    lowercase
                elseif isuppercase(c)
                    uppercase
                else
                    identity
                end).(collect(s))
    lsp = collect(sp)
    l = length(sp) > 1 ? (n -> 1 + round(Int, (length(fs) - 1) * (n - 1) / (length(lsp) - 1))).(1:length(lsp)) : 1:1
    join(broadcast((f, c) -> f(c), fs[l], lsp))
end

function test()
    f = hsr("windows", "harmony")
    println(f("Windows 10 is the newest W.I.N.D.O.W.S version"))
    println(f("WindoWS 2000 is built on NT"))
    println(f("WINdows is funny"))
end

test()