N, A, B = map(int, raw_input().split())
if N == 1 and A != B:
    print 0
    exit()
if A > B:
    print 0
    exit()
if N == 1:
    print 1
    exit()

print (B - A) * (N - 2) + 1
