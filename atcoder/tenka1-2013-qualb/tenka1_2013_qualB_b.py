Q, L = map(int, raw_input().split())
stack = []
youryo = 0

def my_push(n, m):
    global youryo
    if youryo > L - n:
        print 'FULL'
        exit()
    stack.append((m, n))
    youryo += n

def my_pop(n):
    global youryo
    if youryo < n:
        print 'EMPTY'
        exit()
    youryo -= n
    while n > 0 and stack[-1][1] <= n:
        n -= stack[-1][1]
        stack.pop()
    if n != 0:
        stack[-1] = (stack[-1][0], stack[-1][1]-n)
    
def my_top():
    global youryo
    if youryo == 0:
        print 'EMPTY'
        exit()
    print stack[-1][0]

def my_size():
    global youryo
    print youryo

for i in xrange(Q):
    query = raw_input().split()
    if query[0] == 'Push':
        my_push(int(query[1]), int(query[2]))
    elif query[0] == 'Pop':
        my_pop(int(query[1]))
    elif query[0] == 'Top':
        my_top()
    else:
        my_size()
print 'SAFE'
