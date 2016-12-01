import math

n = int(raw_input())
sq = -1
for i in range(1, 1000):
    s = i*i
    if s == n:
        print 0
        exit()
    if s > n:
        break
    sq = s

ans = n - sq
amari = 0
while amari < ans:
    tmp_n = n - amari
    for i in range(1, int(math.sqrt(tmp_n))+5):
        if tmp_n % i == 0:
            j = tmp_n/i
            if abs(j - i) + amari < ans:
                ans = abs(j - i) + amari
    amari += 1
print ans
