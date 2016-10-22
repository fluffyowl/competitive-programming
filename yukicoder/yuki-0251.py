def powermod(n, x, mod):
    if n % mod == 0:
        return 0 if x > 0 else 1
    elif n == 0:
        return 0

    n %= mod
    ans = 1
    while x >= 1:
        if x%2:
            ans = ans * n % mod
        n = n * n % mod
        x /= 2
    return ans

MOD = 129402307
print powermod(int(raw_input()), int(raw_input()), MOD)

