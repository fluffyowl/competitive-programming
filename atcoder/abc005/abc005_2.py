N = int(raw_input())
L = []
La = L.append
for i in range(N):
    La(int(raw_input()))
print min(L)
