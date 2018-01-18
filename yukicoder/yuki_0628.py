N = int(raw_input())
D = {}
for i in xrange(N):
    raw_input()
    M, S = map(int, raw_input().split())
    SS = raw_input().split()
    for s in SS:
        if s in D:
            D[s] += S
        else:
            D[s] = S

cnt = 0
for k, v in sorted(D.items(), key=lambda x: (-x[1], x[0])):
    print k, v
    cnt += 1
    if cnt >= 10:
        break

