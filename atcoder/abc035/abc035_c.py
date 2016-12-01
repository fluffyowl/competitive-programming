N, Q = map(int, raw_input().split())
a = [0 for i in range(N)]
for q in range(Q):
    L, R = map(int, raw_input().split())
    a[L-1] += 1
    if not R == N:
        a[R] -= 1

s = 0
for i in range(N):
    old = int(a[i])
    a[i] = (a[i] + s) % 2
    s += old
    
print ''.join([str(i) for i in a])
