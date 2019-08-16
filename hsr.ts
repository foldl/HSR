function hsr(s: string, sp: string): (x: string) => string
{
    return (x: string) => [(_:string) => _, (_: string) => _.split("").join(".")]
                          .reduce((acc: string, f) => hsr0(f(s), f(sp), acc), x);
}

function hsr0(s: string, sp: string, original: string)
{
    let lo = original.toLowerCase();
    let i = 0;
    let r = "";
    while (true)
    {
        let j = lo.indexOf(s.toLowerCase(), i);
        if (j < 0) break;
        r += original.substr(i, j - i) + caseawarenessconvert(original.substr(j, s.length), sp);
        i = j + s.length;
    }
    return r + original.substr(i, original.length - i);
}

function caseawarenessconvert(s: string, sp: string): string
{
    let fs = s.split("").map(function (c: string) {
        switch ((c.toLowerCase() === c ? 10 : 0) + (c.toUpperCase() === c ? 1 : 0))
        {
            case 10: return (_: string) => _.toLowerCase();
            case  1: return (_: string) => _.toUpperCase();
            default: return (_: string) => _;
        }
    });
    let l = sp.length > 1 ? sp.split("").map((c, i) => Math.round((s.length - 1) * i / (sp.length - 1))) : [0];
    return sp.split("").map((c, i) => fs[i](c)).join("");
}

function test()
{
    let f = hsr("windows", "harmony");
    console.log(f("Windows 10 is the newest W.I.N.D.O.W.S version"));
    console.log(f("WindoWS 2000 is built on NT"));
    console.log(f("WINdows is funny"));
}

test()