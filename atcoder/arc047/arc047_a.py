N, L = map(int, raw_input().split())
tab = 1
c = 0
for s in raw_input():
    if s == '+':
        tab += 1
        if tab > L:
            tab = 1
            c += 1
    else:
        tab -=1
print c
