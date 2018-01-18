S = raw_input()
two = 0
five = 0
for s in S:
    if s == '2':
        if five > 0:
            two += 1
            five -= 1
        else:
            two += 1
    else:
        if two > 0:
            two -= 1
            five += 1
        else:
            print -1
            exit()
if two > 0:
    print -1
else:
    print five S = raw_input()
two = 0
five = 0
for s in S:
    if s == '2':
        if five > 0:
            two += 1
            five -= 1
        else:
            two += 1
    else:
        if two > 0:
            two -= 1
            five += 1
        else:
            print -1
            exit()
if two > 0:
    print -1
else:
    print five
