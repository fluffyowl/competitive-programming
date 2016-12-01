N, a = map(int, raw_input().split())
k = int(raw_input())
b = map(int, raw_input().split())

index_tango = [a]
tango_index = {a:0}

i = 0
while True:
    i += 1
    a = b[a-1]
    if a in tango_index:
        loop = i - tango_index[a]
        amari = (k - i) % loop
        print index_tango[tango_index[a]+amari]
        break
    index_tango.append(a)
    tango_index[a] = i
    if i == k:
        print a
        break
