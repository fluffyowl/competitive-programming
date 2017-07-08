n, m = map(int, raw_input().split())

if n <= m:
    print 1
elif m == 1:
    print -1
elif n % 2 == 0 and m >= n / 2:
    print 2
else:
    print -1

