n = input()
w2 = raw_input()
words = set([w2])
for i in range(1, n):
    w1, w2 = w2, raw_input()
    if w1[-1] != w2[0] or w2 in words:
        if i % 2:
            print 'WIN'
        else:
            print 'LOSE'
        exit()
    words.add(w2)
print 'DRAW'
