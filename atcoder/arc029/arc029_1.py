a = [int(raw_input()) for i in range(int(raw_input()))]
while len(a) < 4:
    a.append(0)
a.sort()
print min(max(a[0]+a[1]+a[2], a[3]), max(a[0]+a[3], a[1]+a[2]))
