last = [0, 31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def uruu(y):
    if y%400 == 0:
        return True
    elif y%100 == 0:
        return False
    elif y%4 == 0:
        return True
    else:
        return False

def incl_date(y,m,d):
    if m == 2:
        last_day = 29 if uruu(y) else 28
    else:
        last_day = last[m]

    if d == last_day:
        if m == 12:
            return y+1, 1, 1
        else:
            return y, m+1, 1
    else:
        return y, m, d+1

    
Y, M, D = map(int, raw_input().split('/'))
while Y%(M*D) != 0:
    Y, M, D = incl_date(Y, M, D)
print '%d/%02d/%02d'%(Y, M, D)
