m = 1000003
x, N = map(int, raw_input().split())
A = map(int, raw_input().split())
print sum(pow(x, a, m) for a in A) % m
