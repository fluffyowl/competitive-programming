R, C = map(int, raw_input().split())
if R == C:
    print (R/2)*(2*(R%2+1)+((R/2)-1)*2)/2+R%2-1
else:
    if R > C:
        R, C = C, R
    print C*(R/2) + (R%2)*(C/2+C%2) -1

