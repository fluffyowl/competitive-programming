N, M = map(int, raw_input().split())
rinsetsu = [[] for i in range(N+1)]
for i in range(M):
    A, B = map(int, raw_input().split())
    rinsetsu[A].append(B)
    rinsetsu[B].append(A)

ans = [0 for i in range(N+1)]
for n in range(1, N+1):
    fof = set()
    for m in rinsetsu[n]:
        for mm in rinsetsu[m]:
            if mm != n and mm not in rinsetsu[n]:
                fof.add(mm)
    ans[n] = len(fof)
                
for i in range(1, N+1):
    print ans[i]
