N = input()
participants = []
pa = participants.append
rating_hand = {}
for i in xrange(N):
    r, h = map(int, raw_input().split())
    h -= 1
    if r in rating_hand:
        rating_hand[r][h] += 1
    else:
        rating_hand[r] = [0, 0, 0]
        rating_hand[r][h] += 1
    pa((r, h))

ue = {}
st = {}
s = 0
for r in sorted(rating_hand.keys()):
    st[r] = s
    s += sum(rating_hand[r])
s = 0
for r in sorted(rating_hand.keys(), reverse=True):
    ue[r] = s
    s += sum(rating_hand[r])

for p in participants:
    r, h = p
    print st[r]+rating_hand[r][(h+1)%3], ue[r]+rating_hand[r][h-1], rating_hand[r][h]-1
