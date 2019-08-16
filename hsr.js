function hsr(s, sp) {
    return function (x) { return [function (_) { return _; }, function (_) { return _.split("").join("."); }]
        .reduce(function (acc, f) { return hsr0(f(s), f(sp), acc); }, x); };
}
function hsr0(s, sp, original) {
    var lo = original.toLowerCase();
    var i = 0;
    var r = "";
    while (true) {
        var j = lo.indexOf(s.toLowerCase(), i);
        if (j < 0)
            break;
        r += original.substr(i, j - i) + caseawarenessconvert(original.substr(j, s.length), sp);
        i = j + s.length;
    }
    return r + original.substr(i, original.length - i);
}
function caseawarenessconvert(s, sp) {
    var fs = s.split("").map(function (c) {
        switch ((c.toLowerCase() === c ? 10 : 0) + (c.toUpperCase() === c ? 1 : 0)) {
            case 10: return function (_) { return _.toLowerCase(); };
            case 1: return function (_) { return _.toUpperCase(); };
            default: return function (_) { return _; };
        }
    });
    var l = sp.length > 1 ? sp.split("").map(function (c, i) { return Math.round((s.length - 1) * i / (sp.length - 1)); }) : [0];
    return sp.split("").map(function (c, i) { return fs[i](c); }).join("");
}
function test() {
    var f = hsr("windows", "harmony");
    console.log(f("Windows 10 is the newest W.I.N.D.O.W.S version"));
    console.log(f("WindoWS 2000 is built on NT"));
    console.log(f("WINdows is funny"));
}
test();
