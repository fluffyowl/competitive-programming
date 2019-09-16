N = input()
A = map(int, raw_input().split())

MOD = 10 ** 9 + 7

ans = 0
C = 1

for i in xrange(N):
    ans += C * A[i]
    ans %= MOD
    C *= N - i - 1
    C %= MOD
    C *= pow(i + 1, MOD - 2, MOD)
    C %= MOD

print ans

