import heapq

N = input()
S = [raw_input() for _ in xrange(N)]
maxlen = max(map(len, S)) + 1
q = []
for i in xrange(N):
    heapq.heappush(q, S[i]+'{'*(maxlen-len(S[i])+1))

ans = ''
while len(q) > 0:
    s = heapq.heappop(q)
    if s[0] == '{':
        continue
    ans += s[0]
    heapq.heappush(q, s[1:])
print ans

