N = input()
cards = [int(raw_input()) for i in xrange(N)]
ans = cards[0] / 2
cards[0] %= 2

for i in xrange(1, N):
    if cards[i] != 0 and cards[i-1] != 0:
        cards[i] -= 1
        ans += 1
    ans += cards[i]/2
    cards[i] %= 2

print ans
