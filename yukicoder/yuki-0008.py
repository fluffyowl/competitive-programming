for i in xrange(input()):
    N, K = map(int, raw_input().split())
    print 'Win' if (N-1)%(K+1) else 'Lose'

