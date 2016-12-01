N, K = map(int, raw_input().split())
s = [0 for i in range(N)]
for i in range(N):
    s[i] = int(raw_input())
for i in range(N-2):
    if sum(s[i:i+3]) < K:
        print i+3
        exit()
print -1
