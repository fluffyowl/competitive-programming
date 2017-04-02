n, k = map(int, raw_input().split())
aa = map(int, raw_input().split())
x = 0
for a in aa:
    x += a
    if x == n:
        print n
        exit()
    if x > n:
        x = 2*n-x
print x
