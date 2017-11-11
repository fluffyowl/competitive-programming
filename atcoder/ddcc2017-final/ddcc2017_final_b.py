from fractions import gcd

N, Z = map(int, raw_input().split())
A = map(int, raw_input().split())
B = [gcd(a, Z) for a in A]

ans = 1
for b in B:
    ans = ans * b / gcd(ans, b)

print ans
