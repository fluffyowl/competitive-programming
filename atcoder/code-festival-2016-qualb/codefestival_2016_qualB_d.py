N = input()
maximum = 1
ans = int(raw_input()) - 1
for i in xrange(N-1):
    n = int(raw_input())
    if n <= maximum:
        continue
    if n == maximum + 1:
        maximum += 1
        continue
    ans += (n-1)/(maximum+1)
print ans
