K, A, B = map(int, raw_input().split())

if A >= K:
    print 1
    exit()
if A <= B:
    print -1
    exit()

x = (K-B-1)/(A-B)+1
print 2*x-1 K, A, B = map(int, raw_input().split())

if A >= K:
    print 1
    exit()
if A <= B:
    print -1
    exit()

x = (K-B-1)/(A-B)+1
print 2*x-1
