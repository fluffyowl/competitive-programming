N, T = map(int, raw_input().split())
A, B = [], []
for i in range(N):
    a, b = map(int, raw_input().split())
    A.append(a)
    B.append(a-b)
sa = sum(A)
B.sort(reverse=True)
for i, b in enumerate(B):
    if sa <= T:
        print i
        break
    sa -= b
else:
    print N if sa <= T else -1
