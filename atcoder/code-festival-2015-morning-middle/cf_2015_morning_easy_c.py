N, K, M, R = map(int, raw_input().split())
s = []
for i in range(N-1):
    s.append(input())
s.sort(reverse=True)
if sum(s[:K]) >= K*R:
    print 0
    exit()
x2 = K*R-sum(s[:K-1])
print x2 if x2 <= M else -1
