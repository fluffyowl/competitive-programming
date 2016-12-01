print reduce(lambda x,y:x*y, map(int, raw_input().split()), 1) % (10**9+7)
