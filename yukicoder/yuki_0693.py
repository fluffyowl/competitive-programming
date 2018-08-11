N = input()
A = sorted(map(int, raw_input().split()))
ans = 0
for i, a in enumerate(A):
    ans += abs(a - (i+1))
print ans
