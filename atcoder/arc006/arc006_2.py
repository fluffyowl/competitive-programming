N, L = map(int, raw_input().split())
amida = []
for i in range(L):
    amida.append(raw_input())
start = raw_input().index('o')
c = (start, L-1)
while c[1] >= 0:
    if c[0] > 0 and amida[c[1]][c[0]-1] == '-':
        c = (c[0]-2, c[1]-1)
    elif c[0] < len(amida[0])-1 and amida[c[1]][c[0]+1] == '-':
        c = (c[0]+2, c[1]-1)
    else:
        c = (c[0], c[1]-1)

print c[0]/2 + 1
