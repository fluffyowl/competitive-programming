    

board = []
for i in xrange(4):
    board += map(lambda x:int(x)-1, raw_input().split())
board[board.index(-1)] = 15

move = [-4, -1, 1, 4]
ok = range(16)
def dfs(b, emp, used):
    if b == ok:
        return True
    for m in move:
        new_emp = emp+m
        if 0 <= new_emp < 16 and not used[b[new_emp]]:
            used[b[new_emp]] = True
            b[emp], b[new_emp] = b[new_emp], b[emp]
            if dfs(b, new_emp, used):
                return True
            b[emp], b[new_emp] = b[new_emp], b[emp]
            used[b[new_emp]] = False
    return False

used = [False for _ in xrange(16)]
print 'Yes' if dfs(board, board.index(15), used) else 'No'

