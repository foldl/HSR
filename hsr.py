import functools

def hsr(s, sp):
    return lambda o: functools.reduce(lambda x, f: hsr0(f(s), f(sp), x), [lambda t: t, lambda t: '.'.join(t)], o)

def hsr0(s, sp, orig):
    lo = orig.lower()
    i = 0
    r = ""
    while True:
        j = lo.find(s.lower(), i)
        if j < 0: break
        r += orig[i:j] + caseawarenessconvert(orig[j:j + len(s)], sp)
        i = j + len(s)
    return r + orig[i:]

def caseawarenessconvert(s, sp):
    fs = [ ((lambda s: s.upper()) if c.isupper() else ((lambda s: s.lower()) if c.islower() else lambda s: s)) for c in s ]
    l = [ round((len(s) - 1) * n / (len(sp) - 1)) for n in range(0, len(sp))] if len(sp) > 1 else [0]
    return ''.join([ (fs[fn])(c) for (fn, c) in zip(l, sp)])

def test():
    f = hsr("windows", "harmony")
    print(f("Windows 10 is the newest W.I.N.D.O.W.S version"))
    print(f("WindoWS 2000 is built on NT"))
    print(f("WINdows is funny"))

if __name__ == "__main__":
    test()