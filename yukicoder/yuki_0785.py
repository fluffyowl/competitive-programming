ans = 1

def f():
    S = raw_input()
    if S == "NONE":
        return 16 * 16
    else:
        return (16 - len(S.split(','))) ** 2

print f() * f() * f()

