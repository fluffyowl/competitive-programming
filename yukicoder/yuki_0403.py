a, b, c = map(int, raw_input().split('^'))
p = 10**9+7
d = pow(b, c, p-1) if b%(p-1) > 0 else 0
e = pow(a, d, p) if a%p > 0 else 0
print pow(pow(a, b, p), c, p), e

