N, L = map(int, raw_input().split())
cross = [map(int, raw_input().split()) for _ in xrange(N)]
T = 0
pos = 0
for x, w, t in cross:
    T += x-pos
    if T/t%2 == 1: # red
        T += t-T%t
    elif w > t-T%t: # green (maniawanai)
        T += t+t-T%t
    T += w
    pos = x+w
print T + L - pos
