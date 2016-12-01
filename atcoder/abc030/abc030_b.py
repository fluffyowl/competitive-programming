n, m = map(int, raw_input().split())
n = n - 12 if n >= 12 else n
n = 30 * n + m * 0.5
m = 6 * m
print min(abs(n-m), 360-abs(n-m))
