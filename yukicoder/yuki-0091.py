a = sorted(map(int, raw_input().split()))
while a[2] - a[0] > 2:
    a[0] += 1
    a[2] -= 2
    a.sort()
print min(a)
