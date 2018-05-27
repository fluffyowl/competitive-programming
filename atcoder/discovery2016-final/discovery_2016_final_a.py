N = input()
A = [0 for _ in xrange(N)]

for i in xrange(N):
    a = int(raw_input()) - 1
    if i == 0:
        A[a] = 100000
    elif i == 1:
        A[a] = 50000
    elif i == 2:
        A[a] = 30000
    elif i == 3:
        A[a] = 20000
    elif i == 4:
        A[a] = 10000

for a in A:
    print a
