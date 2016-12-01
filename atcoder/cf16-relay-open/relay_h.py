DAY = 86400
HOURS = 10801
N = input()
okita = [0 for _ in xrange(DAY)]
t = 0
for _ in xrange(N):
    a, b = map(int, raw_input().split())
    t = (t+a)%DAY
    okita[t] += 1
    t = (t+b)%DAY
okita *= 2
okita.insert(0, 0)
for i in xrange(1, DAY*2):
    okita[i] += okita[i-1]
 
 
ans = 0
for i in xrange(DAY+10):
    ans = max(ans, okita[i+HOURS]-okita[i])
print ans
