a, b, c = map(int, raw_input().split())
s = a + b + c
if a % 2 == 1 or b % 2 == 1or c % 2 == 1:
    print 0
    exit()

mem = set()
ans = 0
while True:
    a, b, c = sorted((a, b, c))
    if a % 2 == 1 or b % 2 == 1or c % 2 == 1:
        break
    if (a, b, c) in mem:
        print -1
        exit()
    mem.add((a, b, c))
    na = b / 2 + c / 2
    nb = a / 2 + c / 2
    nc = a / 2 + b / 2
    a, b, c = na, nb, nc
    ans += 1
print ans
