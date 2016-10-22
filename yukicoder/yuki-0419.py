import math
n, m = sorted(map(float, raw_input().split()))
print math.sqrt(m*m-n*n) if m!=n else math.sqrt(m*m*2)
