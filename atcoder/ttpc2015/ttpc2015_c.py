import re
S = raw_input()

while True:
    f = re.findall('o+ookayama', S)
    if not f:
        print S
        break
    T = max(f, key=lambda x:len(x))
    U = T
    while 'oo' in U:
        U = re.sub('oo', 'O', U, count=1)
        U = re.sub('OO', 'o', U, count=1)
    S = re.sub(T, U, S, count=1)
