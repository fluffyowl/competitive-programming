def prime_table(n):
  L = [True for _ in xrange(n + 1)]
  i = 2
  while i * i <= n:
    if L[i]:
      j = i + i
      while j <= n:
        L[j] = False
        j += i
    i += 1

  table = [i for i in xrange(n + 1) if L[i] and i >= 2]
  return table

N, L = map(int, raw_input().split())
ans = 0
for p in prime_table(L):
    a = L-(N-1)*p + 1
    if a <= 0:
        break
    ans += a
print ans

