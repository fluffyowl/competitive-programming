N, K = map(int, raw_input().split())
S = map(int, list(raw_input()))
kau = 0
atari = 0
cases = K / N + (K % N > 0)

for i in xrange(min(len(S), K)):
    s = S[i]
    if atari > 0:
        atari -= 1
    else:
        kau += 1
    atari += s
    #print kau, atari

if kau <= atari or cases == 1:
    print kau
    exit()

ans = kau + max(0, (cases-2)*(kau-atari))

kau = 0
nokori = K - (cases-1)*N 
for i in xrange(nokori):
    s = S[i]
    if atari > 0:
        atari -= 1
    else:
        kau += 1
    atari += s

print ans + kau

