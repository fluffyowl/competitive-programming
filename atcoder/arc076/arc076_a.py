n, m = map(int, raw_input().split())
MOD = 10**9+7

F = [0 for _ in xrange(10**5+10)]
F[0] = 1
F[1] = 1
for i in xrange(2, 10**5+2):
    F[i] = F[i-1] * i % MOD

if abs(n - m) >= 2:
    print 0
elif abs(n - m) == 1:
    print F[n] * F[m] % MOD
else:
    print F[n] * F[m] * 2 % MOD
