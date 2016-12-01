def gcd(a, b):
    while b != 0:
        a, b = b, a%b
    return a

a = int(raw_input())
b = int(raw_input())
n = int(raw_input())

k = a * b / gcd(a, b)
lcm = k

while k < n:
    k += lcm

print k
