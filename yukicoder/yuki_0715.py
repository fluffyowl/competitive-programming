N = 2000
F = [0 for _ in xrange(N)]
F[1] = 1
F[2] = 1
for i in xrange(3, N):
    H = set([F[i-2], F[i-3]])
    j = 1
    while i - 3 - j >= j:
        k = i - 3 - j
        H.add(F[j]^F[k])
        j += 1
    H = sorted(list(H))
    for j in xrange(len(H)+1):
        if j >= len(H) or H[j] != j:
            F[i] = j
            break

n = input()
A = sorted(map(int, raw_input().split()))
B = []

last = -1
cnt = 0
for a in A:
    if last == -1:
        last = a
        cnt = 1
    elif a - last == 1:
        last = a
        cnt += 1
    else:
        B.append(cnt)
        last = a
        cnt = 1
B.append(cnt)

ans = 0
for b in B:
    if b >= N:
        ans ^= F[34*10+b%34]
    else:
        ans ^= F[b]

print "First" if ans else "Second"

