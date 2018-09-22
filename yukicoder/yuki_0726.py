X, Y = map(int, raw_input().split())

def is_prime(n):
    if n == 1:
        return False
    i = 2
    while i * i <= n:
        if n % i == 0:
            return False
        i += 1
    return True

if is_prime(X) and is_prime(Y):
    print "Second"
    exit()

cnt = 0
if is_prime(X):
    cnt = 1
    X += 1
if is_prime(Y):
    cnt = 1
    Y += 1

if is_prime(X) or is_prime(Y):
    print "Second"
    exit()

x = X + 1
y = Y + 1


while not is_prime(x):
    x += 1

while not is_prime(y):
    y += 1

d = x - X + y - Y
print "First" if (d + cnt) % 2 else "Second"

