import math
n = input()
p = []
for i in range(n):
    p.append((map(int, raw_input().split())))
m = 0
for i in range(n):
    for j in range(i+1, n):
        d = (p[i][0] - p[j][0])**2 + (p[i][1] - p[j][1])**2
        if d > m:
            m = d
print math.sqrt(m)
