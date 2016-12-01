c = 2*10**12
a, k = map(int, raw_input().split())
if k == 0:
    print c-a
    exit()
i = 0
while a < c:
    a += 1 + k*a
    i += 1
print i
