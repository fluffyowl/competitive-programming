N, S, T = map(int, raw_input().split())
w = [int(raw_input())]
for i in range(1, N):
    w.append(w[-1] + int(raw_input()))
print sum(map(lambda x: S<=x<=T, w))
