l, r, n = map(int, input().split())

if n == 1:
    print(r - l + 1)
    exit()

if l % n == 0:
    ll = l
else:
    ll = l + n - l % n

if r % n == 0:
    rr = r - 1
else:
    rr = r - r % n - 1

base = ((rr + 1) - l) // n
ln = l % n
rn = r % n

for i in range(n):
    x = base
    if i >= ln and ln != 0:
        x += 1
    if i <= rn:
        x += 1
    print(x)
