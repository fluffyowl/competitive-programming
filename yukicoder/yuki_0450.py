vl, vr = map(float, raw_input().split())
d1 = float(raw_input())
w = float(raw_input())

t1 = d1/(vr+w)
a1 = w * t1
d2 = d1-(vl+vr) * t1
t2 = d2 / (vl+w)
a2 = w * t2
x = ((w-vl) * (w-vr)) / ((w+vr) * (w+vl))

print '%.7f'%((a1+a2)/(1-x))

