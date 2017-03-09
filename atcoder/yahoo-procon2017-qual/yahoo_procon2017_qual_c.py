N, K = map(int, raw_input().split())
A = sorted(map(lambda x: int(x)-1, raw_input().split()))
S = [raw_input() for _ in xrange(N)]
B = set(A)
C = set([i for i in xrange(N)])

if len(A) == N:
    print
    exit()

m = min(len(S[i]) for i in A)
for i in A:
    if len(S[i]) == m:
        p = S[i]
        break

for i in xrange(len(p)):
    fusoku = False
    yokei = False
    to_remove = []
    for j in C:
        if j in B and len(S[j]) < i + 1:
            fusoku = True
            break
        elif j in B and S[j][i] != p[i]:
            fusoku = True
            break
        elif j not in B and len(S[j]) < i + 1:
            to_remove.append(j)
        elif j not in B and S[j][i] == p[i]:
            yokei = True
        elif j not in B and S[j][i] != p[i]:
            to_remove.append(j)
    if fusoku:
        print -1
        exit()
    if not yokei:
        print p[:i+1]
        exit()
    for j in to_remove:
        C.discard(j)
print -1
