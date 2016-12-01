n, k, x, y = [input() for _ in range(4)]
print x * min(n, k) + y * max(n-k, 0)
