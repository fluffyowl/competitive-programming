aw, ab = map(int, raw_input().split())
bw, bb = map(int, raw_input().split())
c, d = map(int, raw_input().split())

if c > ab:
    c -= ab
    ab = 0
    aw -= c
    bw += c
print aw + min(d, bw)

