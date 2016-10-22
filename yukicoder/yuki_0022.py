N, K = map(int, raw_input().split())
S = raw_input()
p = []
for i, c in enumerate(S, start=1):
    if c == '(':
        p.append(i)
    elif i == K or p[-1] == K:
        print p[-1] if i == K else i
        break
    else:
        p.pop()

