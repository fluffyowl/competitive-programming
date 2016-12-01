A, B, C, D = map(int, raw_input().split())
print sorted([sorted(map(int, raw_input().split()))[A-B] for i in xrange(C)])[C-D]
