A = map(int, raw_input().split())
S = ""
for a in A:
    if a % 3 == 0 and a % 5 == 0:
        S += "aaaaaaaa"
    elif a % 3 == 0 or a % 5 == 0:
        S += "aaaa"
    else:
        S += str(a)

print len(S)

