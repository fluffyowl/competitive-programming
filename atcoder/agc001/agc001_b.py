def calc(a, b):
    if a <= 0 or b <= 0:
        return 0
    if a == b:
        return a
    a, b = min(a, b), max(a, b)
    x = max(1, b / (2 * a))
    return calc(b-x*a, a) + 2 * a * x

N, X = map(int, raw_input().split())
print calc(X, N-X) + N
