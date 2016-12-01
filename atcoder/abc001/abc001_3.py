d, w = map(int, raw_input().split())

if 112.5 <= d < 337.5: d = 'NNE'
elif 337.5 <= d < 562.5: d = 'NE'
elif 562.5 <= d < 787.5: d = 'ENE'
elif 787.5 <= d < 1012.5 : d = 'E'
elif 1012.5 <= d < 1237.5: d = 'ESE'
elif 1237.5 <= d < 1462.5: d = 'SE'
elif 1462.5 <= d < 1687.5: d = 'SSE'
elif 1687.5 <= d < 1912.5: d = 'S'
elif 1912.5 <= d < 2137.5: d = 'SSW'
elif 2137.5 <= d < 2362.5: d = 'SW'
elif 2362.5 <= d < 2587.5: d = 'WSW'
elif 2587.5 <= d < 2812.5: d = 'W'
elif 2812.5 <= d < 3037.5: d = 'WNW'
elif 3037.5 <= d < 3262.5: d = 'NW'
elif 3262.5 <= d < 3487.5: d = 'NNW'
else: d = 'N'

w = 100*w/60
d1 = int(str(w)[-1])
if d1 <5:
    w -= d1
else:
    w += 10-d1
w /= 10
if 0 <= w <= 2: w = 0
elif 03 <= w <= 15: w = 1
elif 16 <= w <= 33: w = 2
elif 34 <= w <= 54: w = 3
elif 55 <= w <= 79: w = 4
elif 80 <= w <= 107: w = 5
elif 108 <= w <= 138: w = 6
elif 139 <= w <= 171: w = 7
elif 172 <= w <= 207: w = 8
elif 208 <= w <= 244: w = 9
elif 245 <= w <= 284: w = 10
elif 285 <= w <= 326: w = 11
elif 327 <= w: w = 12

if w == 0:
    print 'C 0'
else:
    print d, w
