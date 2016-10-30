import math

N = input()
B = input()
A = map(float, raw_input().split())

bibun = 0
for a in A:
    bibun += a*B**(a-1)

sekibun = 0
for a in A:
    if a == -1:
        sekibun += math.log(abs(B))
    else:
        sekibun += 1/(a+1)*B**(a+1)
    
print bibun
print sekibun

