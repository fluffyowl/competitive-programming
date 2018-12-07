N, M, A, B = map(int, raw_input().split())
ans = [max(A, B) for _ in xrange(N)]
for _ in xrange(M):
    L, R = map(int, raw_input().split())
    L -= 1
    for i in xrange(L, R):
        ans[i] = A
print sum(ans)
