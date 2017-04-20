a, b, c = map(int, raw_input().split())
n = input()
print max(0, n-a), max(0, 2*n-b), max(0, 3*n-c)
