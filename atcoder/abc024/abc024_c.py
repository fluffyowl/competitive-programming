N, D, K = map(int, raw_input().split())
LR = []
LRa = LR.append
minzoku = []
for _ in xrange(D):
    LRa(map(int, raw_input().split()))
for _ in xrange(K):
    minzoku.append(map(int, raw_input().split()))

for s, g in minzoku:
    min_t = s
    max_t = s
    for j, lr in enumerate(LR):
        l, r = lr
        if l <= min_t <= r:
            min_t = l
        if l <= max_t <= r:
            max_t = r
        if min_t <= g <= max_t:
            print j+1
            break
