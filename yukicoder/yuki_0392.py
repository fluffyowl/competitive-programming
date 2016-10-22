print '\n'.join(format(input()+1, 'b').replace('0','L').replace('1','R')[1:] for _ in xrange(input()))
