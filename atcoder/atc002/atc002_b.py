N, M, P = map(int, raw_input().split())

def my_pow(n, k):
    if k == 0:
        return 1
    elif k%2 == 0:
        a = my_pow(n, k/2)
        return a * a % M
    else:
        return my_pow(n, k-1) * n % M

print my_pow(N, P)
