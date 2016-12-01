N = int(raw_input())
a = [i for i in map(int, raw_input().split()) if i != 0]
n, d = sum(a), len(a)
print n/d if n%d==0 else n/d+1
