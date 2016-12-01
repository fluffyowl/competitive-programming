N, K = map(int, raw_input().split())
a = []
aa = a.append
for i in range(N):
    aa(int(raw_input()))

if K == 1:
    print N
    exit()

L, R = 0, 1
ans = 0
while R < N:
    if a[R] <= a[R-1]:
        s = (R - L) - K + 1
        if s > 0:
            ans += s
        L, R = R, R+1
    else:
        R += 1
        
if a[N-1] > a[N-2]:
    s = (N - L) - K + 1
    if s > 0:
        ans += s
print ans
