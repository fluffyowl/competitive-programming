def keta(n):
    return len(str(n))

def F(a, b):
    return max(keta(a), keta(b))

N = input()

i = 1
ans = float('inf')
while i * i <= N:
    if N % i == 0:
        ans = min(ans, F(i, N/i))
    i += 1
print ans
