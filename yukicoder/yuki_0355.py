import sys

def communicate(S):
    print S
    sys.stdout.flush()
    ans = map(int, raw_input().split())
    if ans == [4, 0]:
        exit()
    return ans

ans = [-1, -1, -1, -1]
for keta in xrange(4):
    others = ['7','8','9']
    hits = []
    for i in xrange(7):
        hit, blow = communicate(' '.join(others[:keta]+[str(i)]+others[keta:]))
        hits.append(hit)
    for i in xrange(7):
        if hits[0] > hits[i]:
            ans[keta] = 0
            break
        elif hits[0] < hits[i]:
            ans[keta] = i

    if ans[keta] != -1:
        continue
    
    others = ['0','1','2']
    hits = []
    for i in xrange(7, 10):
        hit, blow = communicate(' '.join(others[:keta]+[str(i)]+others[keta:]))
        hits.append(hit)
    for i in xrange(3):
        if hits[0] > hits[i]:
            ans[keta] = 7
            break
        elif hits[0] < hits[i]:
            ans[keta] = 7+i
communicate(' '.join(map(str, ans)))

