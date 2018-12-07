from fractions import gcd

N = input()
A = map(int, raw_input().split())
G = A[0]
for i in xrange(1, N):
    G = gcd(G, A[i])

print ':'.join(map(str, [A[i]/G for i in xrange(N)]))

