import math

N = int(raw_input())
r = []
for i in range(N):
    r.append(int(raw_input()))
r.sort(reverse=True)
s = 0
for i in r[::2]:
    s += i**2
for i in r[1::2]:
    s -= i**2
print math.pi * s
