from fractions import gcd
N, D = map(int, raw_input().split())
print N/gcd(N,D)-1

