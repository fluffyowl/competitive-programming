def is_prime(n):
    for i in xrange(2, n):
        if n % i == 0:
            return False
    return True

N = input()
ans = 0
for i in xrange(2, N+1):
    if is_prime(i):
        ans += i
print ans

