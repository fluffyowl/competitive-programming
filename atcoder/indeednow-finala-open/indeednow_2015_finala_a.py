n = input()
a = sorted(map(int, raw_input().split()))
b = map(sum, zip(a, a[::-1]))
print max(b) - min(b)
