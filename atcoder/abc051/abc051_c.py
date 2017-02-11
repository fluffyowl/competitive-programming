sx, sy, tx, ty = map(int, raw_input().split())
sx, sy, tx, ty = 0, 0, tx-sx, ty-sy

ans1 = 'R'*tx + 'U'*ty + 'L'*tx + 'D'*ty

ans2 = 'D' + 'R'*(tx+1) + 'U'*(ty+1) + 'L'

ans3 = 'U' + 'L'*(tx+1) + 'D'*(ty+1) + 'R'

print ans1 + ans2 + ans3
