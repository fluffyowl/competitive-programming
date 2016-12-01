N = input()
a = map(int, raw_input().split())
m = int(round(sum(a)/float(N)))
print sum(map(lambda x:(x-m)**2, a))
