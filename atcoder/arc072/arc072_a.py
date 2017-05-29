def solve(N, A):
    a = A[0]
    ans = 0
    for i in xrange(1, N):
        if a > 0 and a + A[i] < 0:
            a = a + A[i]
        elif a > 0 and a + A[i] >= 0:
            ans += A[i] + a + 1
            a = -1
        elif a < 0 and a + A[i] > 0:
            a = a + A[i]
        else:
            ans += -(A[i]+a)+1
            a = 1
    return ans


N = input()
A = map(int, raw_input().split())

if A[0] == 0:
    A[0] = -1
    ans1 = solve(N, A) + 1
    A[0] = 1
    ans2 = solve(N, A) + 1
    print min(ans1, ans2)
else:
    ans1 = solve(N, A)
    if A[0] > 0:
        tmp = A[0] + 1
        A[0] = -1
    else:
        tmp = -A[0] + 1
        A[0] = 1
    ans2 = solve(N, A) + tmp
    print min(ans1, ans2)
