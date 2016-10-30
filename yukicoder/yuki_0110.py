Nw = input()
Ww = sorted(list(set(map(int, raw_input().split()))))
Nb = input()
Bb = sorted(list(set(map(int, raw_input().split()))))

def solve(last):
    ans = 0
    W = Ww[:]
    B = Bb[:]
    while len(W) > 0 and len(B) > 0:
        if W[-1] == B[-1]:
            a = W.pop()
            B.pop()
            ans += 1
            if last == 'B':
                last = 'W'
            elif last == 'W':
                last = 'B'
        elif W[-1] > B[-1]:
            a = W.pop()
            if last == 'B':
                ans += 1
                last = 'W'
        else:
            a = B.pop()
            if last == 'W':
                ans += 1
                last = 'B'
    if len(W) > 0 and last == 'B':
        ans += 1
    elif len(B) > 0 and last == 'W':
        ans += 1
    return ans

print max(solve('B'), solve('W'))

