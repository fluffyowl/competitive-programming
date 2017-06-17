N, K = map(int, raw_input().split())
if K == 0 or K > N:
    print 0
elif N % 2 == 1 and K == N / 2 + 1:
    print N - 1
else:
    print N - 2

