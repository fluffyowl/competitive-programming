Y, M, D = map(int, raw_input().split())

def solve():
    if Y == 1989:
        if M >= 2:
            return True
        else:
            return D >= 8
    elif 1990 <= Y <= 2018:
        return True
    elif Y == 2019:
        return M <= 4
    else:
        return False

print "Yes" if solve() else "No"

