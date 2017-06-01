S = raw_input()

if S.startswith('0'):
    S = '1' + S

N = len(S)

ind = 1
while ind < N and S[ind] == '0':
    ind += 1

first = S[:ind]
tail = S[ind:]
if len(tail) == 0:
    print first, 1
    exit()

second = ''
for i in xrange(len(tail)):
    second += tail[i]
    d = int(second) - int(first)
    if (d <= 0):
        continue
    s = first + second
    n = int(second)
    while len(s) < len(S):
        n += d
        s += str(n)
    if (s.startswith(S)):
        print first, d
        exit()

while int(first) > int(tail + '0'):
    tail += '0'

for i in xrange(10):
    if int(first) < int(tail+str(i)):
        tail += str(i)
        break
    
print first, int(tail) - int(first)
