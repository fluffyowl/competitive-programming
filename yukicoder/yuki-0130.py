N = input()
a = map(int, raw_input().split())

def rec(L, p):
    if p > 32 or len(L) == 0:
        return 0
    L0 = []
    L1 = []
    b = (1 << (32-p))
    for e in L:
        if e & b:
            L1.append(e)
        else:
            L0.append(e)
    if len(L0) == 0:
        return rec(L1, p+1)
    elif len(L1) == 0:
        return rec(L0, p+1)
    else:
        return b + min(rec(L0, p+1), rec(L1, p+1))

print rec(a, 0)

