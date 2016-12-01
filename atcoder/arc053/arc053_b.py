S = raw_input()
count = {}
for s in S:
    if s in count:
        count[s] += 1
    else:
        count[s] = 1

bunbo = 0
bunshi = 0
for i in count.values():
    if i%2 == 1:
        bunbo += 1
    bunshi += i/2

if bunbo <= 0:
    print len(S)
else:
    print (bunshi / bunbo)*2 + 1
