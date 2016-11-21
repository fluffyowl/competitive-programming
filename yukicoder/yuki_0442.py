from fractions import gcd

a, b = map(int, raw_input().split())
print gcd(a+b, a*b)

