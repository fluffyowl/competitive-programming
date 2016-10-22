N, M = map(int, raw_input().split())
C = sorted(map(int, raw_input().split()))
for i in xrange(N):
    M -= C[i]
    if M == 0:
        print i+1
        break
    elif M < 0:
        print i
        break
