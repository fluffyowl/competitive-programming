N = int(raw_input())
h, m, s = 0,0,0
h = N / 3600
m = (N - h*3600) / 60
s = N - h*3600 - m*60
print "%02d:%02d:%02d" % (h, m, s)
