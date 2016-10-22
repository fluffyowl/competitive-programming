MOD = 10**9+7
a = 0
for i in range(input()):
    b, c = map(int, raw_input().split())
    a = (a + (b/2 + b%2)*c) % MOD
print a
