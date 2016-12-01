def valid(b):
    for i in range(8):
        if b.count(i) > 1:
            return False
    out = set()
    for r, c in enumerate(b):
        if c is None:
            continue
        if r+c in out:
            return False
        out.add(r+c)
    for r in range(7):
        if b[r] is None:
            continue
        for c in range(r+1, 8):
            if b[c] is None:
                continue
            if r-c == b[r]-b[c]:
                return False
    return True

def print_board(b):
    for i in b:
        L = ['.'] * 8
        L[i] = 'Q'
        print ''.join(L)

board = [None for i in range(8)]
for i in range(8):
    row = raw_input()
    if row.count('Q') >= 2:
        print "No Answer"
        exit()
    if 'Q' in row:
        board[i] = row.index('Q')

stack = [board]
while len(stack) != 0:
    b = stack.pop()
    if not valid(b):
        continue
    if not None in b:
        print_board(b)
        exit()
    tugi = b.index(None)
    for i in range(8):
        if i not in b:
            new_board = b[:]
            new_board[tugi] = i
            stack.append(new_board)

print 'No Answer'
