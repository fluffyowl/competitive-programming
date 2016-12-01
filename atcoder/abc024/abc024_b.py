N, T = map(int, raw_input().split())
start = int(raw_input())
end = start
s = 0
for i in range(N-1):
    t = int(raw_input())
    if t - end <= T:
        end = t
    else:
        s += end - start + T
        start, end = t, t
print s + end - start + T
