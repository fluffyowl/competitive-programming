N = int(raw_input())
buka = [[] for i in range(N)]
for i in range(1, N):
    joushi = int(raw_input())-1
    buka[joushi].append(i)

def rec(num):
    if len(buka[num]) == 0:
        return 1
    bukas = map(rec, buka[num])
    return max(bukas) + min(bukas) + 1

print rec(0)
