N = int(raw_input())
sump = 0
maxp = float('-inf')
for i in range(N):
    a, b = raw_input().split()
    b = int(b)
    sump += b
    if b > maxp:
        maxp = b
        maxname = a
print maxname if maxp > sump/2 else 'atcoder'
