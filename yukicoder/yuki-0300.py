from collections import Counter

def prime_decomposition(n):
    i = 2
    table = []
    while i * i <= n:
        while n % i == 0:
            n /= i
            table.append(i)
        i += 1
    if n > 1:
        table.append(n)
    return table

X = input()
ans = 1
for k, v in Counter(prime_decomposition(X)).items():
    if v%2:
        ans *= k
print ans

