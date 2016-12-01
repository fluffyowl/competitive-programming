MOD = 10**9 + 7
n = int(raw_input())
times = {}
for i in range(n):
    t = int(raw_input())
    if t in times:
        times[t] += 1
    else:
        times[t] = 1

tk = sorted(times.keys())
max_t = tk[-1]
mtv = max(times.values())+1
factorial = [1 for i in xrange(mtv)]
for i in xrange(2, mtv):
    factorial[i] = factorial[i-1] * i % MOD
s = 0
ans1 = 0
ans2 = 1

for t in sorted(tk):
    for i in range(times[t]):
        s += t
        ans1 += s
    ans2 = ans2 * factorial[times[t]] % MOD

print ans1
print ans2
