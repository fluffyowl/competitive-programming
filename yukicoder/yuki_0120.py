from collections import Counter
import heapq

def solve():
    N = int(raw_input())
    L = map(int, raw_input().split())
    L = [-v for v in Counter(L).values()]
    heapq.heapify(L)
    ans = 0
    while len(L) >= 3:
        a, b, c = heapq.heappop(L), heapq.heappop(L), heapq.heappop(L)
        ans += 1
        if a < -1: heapq.heappush(L, a+1)
        if b < -1: heapq.heappush(L, b+1)
        if c < -1: heapq.heappush(L, c+1)
    print ans

for _ in xrange(input()):
    solve()

