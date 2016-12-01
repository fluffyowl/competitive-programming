N = input()
A, B = map(int, raw_input().split())
if A == B:
    print 'Aoki' if N%(A+1) == 0 else 'Takahashi'
else:
    print 'Takahashi' if N <= A or A > B else 'Aoki'
