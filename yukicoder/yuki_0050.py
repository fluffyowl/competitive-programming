N = input()
A = map(int, raw_input().split())
M = input()
B = sorted(map(int, raw_input().split()))[::-1]

def rec(p, L):
    if p > N-1:
        return True
    for i in xrange(len(L)):
        if L[i] >= A[p]:
            L[i] -= A[p]
            if rec(p+1, L):
                return True
            L[i] += A[p]
    return False

for i in xrange(1, M+1):
    if rec(0, B[:i]):
        print i
        break
else:
    print -1

