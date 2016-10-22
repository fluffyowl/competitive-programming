import sys
N, K = map(int, raw_input().split())
if N <= K:
    print N-1
    sys.stdout.flush()
    raw_input()
    exit()
amari = (N-1)%(K+1)
c = 0 if amari == 0 else amari
print c
sys.stdout.flush()
i = int(raw_input())
while i < N:
    c += K+1
    print c
    sys.stdout.flush()
    i = int(raw_input())

