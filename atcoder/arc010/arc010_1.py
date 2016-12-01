N, M, A, B = map(int, raw_input().split())
for i in range(1, M+1):
    if N <= A:
        N += B
    N -= input()
    if N < 0:
        print i
        break
else:
    print 'complete'
