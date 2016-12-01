N, A, B = map(int, raw_input().split())
s = []
for i in range(N):
    s.append(int(raw_input()))
smin = min(s)
smax = max(s)
if smax==smin:
    print -1
    exit()
P = float(B) / (smax-smin)
Q = (N*A - P*sum(s)) / float(N)
print '%.10f %.10f' % (P, Q)
