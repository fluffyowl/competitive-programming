n, a, b, c, d = map(int, raw_input().split())
x = ((n - 1) / a + 1) * b
y = ((n - 1) / c + 1) * d
print min(x, y)
