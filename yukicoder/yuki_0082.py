W, H, C = raw_input().split()
H, W = int(H), int(W)
for i in xrange(C=='W', H+(C=='W')):
    print ['BW'*(W/2)+'B'*(W%2),'WB'*(W/2)+'W'*(W%2)][i%2]
