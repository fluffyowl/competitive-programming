def is_prime(n):
    if n == 2 or n == 3:
        return True
    i = 2
    while i * i <= n:
        if n % i == 0:
            return False
        i += 1
    return True

N = input()
ans = []
for i in xrange(6, 55555, 5):
    if is_prime(i):
        ans.append(i)
        N -= 1
        if N == 0:
            break

print ' '.join(map(str, ans))
