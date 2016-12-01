N = int(raw_input())
H = map(int, raw_input().split())
X = int(raw_input())

for i in range(len(H)):
    if H[i] > X:
        print i+1
        exit()
print len(H)+1
