import datetime

holidays = set()
for i in range(int(raw_input())):
    m, d = map(int, raw_input().split('/'))
    holidays.add(datetime.datetime(2012, m, d))

day = datetime.datetime(2012, 1, 1)
ans = 0
renkyu = 0
while day.year == 2012:
    if day in holidays:
        daikyu = day
        if day.weekday() >= 5:
            while (daikyu.weekday() >= 5 or daikyu in holidays) and daikyu.year == 2012:
                daikyu += datetime.timedelta(days=1)
        holidays.add(daikyu)
        renkyu += 1
    elif day.weekday() >= 5:
        renkyu += 1
    else:
        renkyu = 0
    if renkyu > ans:
        ans = renkyu
    day += datetime.timedelta(days=1)

print ans
