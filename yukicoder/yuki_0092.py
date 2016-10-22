N, M, K = map(int, raw_input().split())
costs = {}
for _ in xrange(M):
    a, b, c = map(int, raw_input().split())
    if c not in costs:
        costs[c] = [(a, b)]
    else:
        costs[c].append((a, b))
K = map(int, raw_input().split())

result = set([i for i in xrange(1, N+1)])
new_result = set()
for k in K:
    for a, b in costs[k]:
        if a in result:
            new_result.add(b)
        if b in result:
            new_result.add(a)
    result = set(new_result)
    new_result = set()

print len(result)
print ' '.join(map(str, sorted(list(result))))
    
    

