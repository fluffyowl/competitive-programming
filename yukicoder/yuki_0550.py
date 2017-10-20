from math import sqrt

A, B, C = map(int, raw_input().split())

f = lambda x: x*x*x + A*x*x + B*x + C

S = (-2 * A + sqrt(4 * A * A - 12 * B)) / 6.0
T = (-2 * A - sqrt(4 * A * A - 12 * B)) / 6.0

hi = int(S) + 1
lo = int(T) - 1

while hi - lo > 1:
    mid = (hi + lo) / 2
    if f(mid) > 0:
        lo = mid
    else:
        hi = mid

a = lo if f(lo) == 0 else hi

AA = A + a
BB = B + a * (A + a)

b = (-AA + sqrt(AA*AA - 4*BB)) / 2.0
c = (-AA - sqrt(AA*AA - 4*BB)) / 2.0
print ' '.join(map(str, sorted([a, int(b), int(c)])))

