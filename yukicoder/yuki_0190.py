from collections import Counter

N = input()
A = sorted(map(int, raw_input().split()))
nega = []
zero = []
posi = []
for a in A:
    if a < 0:
        nega.append(a)
    elif a == 0:
        zero.append(a)
    else:
        posi.append(a)

if len(nega) == 0:
    print 0, min(len(posi),len(zero))+max(0, len(posi)-len(zero))/2, len(zero)/2
    exit()
if len(posi) == 0:
    print min(len(nega),len(zero))+max(0, len(nega)-len(zero))/2, 0, len(zero)/2
    exit()

nega_n = 0
p1 = 0
p2 = len(posi)-1
while p1 < len(nega) and p2 >= 0:
    if nega[p1]+posi[p2] < 0:
        p1 += 1
        p2 -= 1
        nega_n += 1
    else:
        p2 -= 1
nega_n += min(len(zero), len(nega)-nega_n) + max(0,(len(nega)-nega_n-len(zero))/2)

posi_n = 0
p1 = 0
p2 = len(posi)-1
while p1 < len(nega) and p2 >= 0:
    if nega[p1]+posi[p2] > 0:
        p1 += 1
        p2 -= 1
        posi_n += 1
    else:
        p1 += 1
posi_n += min(len(zero), len(posi)-posi_n) + max(0,(len(posi)-posi_n-len(zero))/2)

nega = map(abs, nega)
c1 = Counter(nega)
c2 = Counter(posi)
moist = len(zero)/2
for k in c1:
    moist += min(c1[k], c2[k])

print nega_n, posi_n, moist

