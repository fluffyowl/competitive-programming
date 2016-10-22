import sys

def ask(L):
    print '? ' + ' '.join(map(str, L))
    sys.stdout.flush()
    return raw_input().split()

N = int(raw_input())
A = range(1, N+1) + [0]*N

for i in xrange(1000):
    if i % 2 == 0:
        ans = ask(A)
        for j in xrange(N/2):
            if ans[j] == '>':
                A[j*2], A[j*2+1] = A[j*2+1], A[j*2]
    else:
        ans = ask(A[1:]+[0])
        for j in xrange(N/2-1+N%2):
            if ans[j] == '>':
                A[j*2+1], A[j*2+2] = A[j*2+2], A[j*2+1]
print '! ' + ' '.join(map(str, A[:N]))

