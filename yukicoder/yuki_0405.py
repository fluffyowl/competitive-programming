a = ["XII","I","II","III","IIII","V","VI","VII","VIII","IX","X","XI"]
d = dict(zip(a, range(12)))
b, c = raw_input().split()
print a[(d[b]+int(c))%12]

