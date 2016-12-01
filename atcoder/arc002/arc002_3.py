from itertools import product

b = 'ABXY'
N = int(raw_input())
command = raw_input()
shortcuts = list(product('ABXY', repeat=2))

ans = float('inf')
for i in range(len(shortcuts)-1):
    for j in range(i+1, len(shortcuts)):
        c = 0
        p = 0
        while p <= N-2:
            aaa = (command[p], command[p+1])
            p += 2 if aaa == shortcuts[i] or aaa == shortcuts[j] else 1
            c += 1
        ans = min(ans, c+N-p)

print ans
