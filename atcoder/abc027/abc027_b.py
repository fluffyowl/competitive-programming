N = int(raw_input())
a = map(int, raw_input().split())
if sum(a)%N:
    print -1
    exit()
m = sum(a)/N
clen=0
csum=0
b = 0
for i in range(N-1):
    clen += 1
    csum += a[i]
    if csum%clen == 0 and csum/clen == m:
        clen = 0
        csum = 0
    else:
        b += 1
print b
