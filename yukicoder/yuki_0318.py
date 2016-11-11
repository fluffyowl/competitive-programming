import heapq

N = input()
A = map(int, raw_input().split())
R = {}

for i, a in enumerate(A):
    R[a] = i

q = []
B = [0 for _ in xrange(N)]
for i, a in enumerate(A):
    heapq.heappush(q, -a)
    while R[-q[0]] < i:
        heapq.heappop(q)
    B[i] = -q[0]
print ' '.join(map(str, B))

