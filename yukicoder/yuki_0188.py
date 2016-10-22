import datetime

d = datetime.datetime(2015, 1, 1)
ans = 0
while d.year == 2015:
    if d.month == d.day/10 + d.day%10:
        print d
        ans += 1
    d += datetime.timedelta(days=1)
print ans
