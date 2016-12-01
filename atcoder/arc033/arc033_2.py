na, nb = map(int, raw_input().split())
a = set(map(int, raw_input().split()))
b = set(map(int, raw_input().split()))
print float(len(a&b)) / len(a|b)
