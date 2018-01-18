t = io.read("*n")
io.read()
a = io.read("*n")
b = io.read("*n")
c = io.read("*n")
d = io.read("*n")
e = io.read("*n")

die = {a, -a, b, -b, c, -c}
mod = 1000000007
ofs = 10010
lb = -10000
ub =  10000
dp = {}

for i = 1, t+1 do
    dp[i] = {}
    for j = 1, 20202 do
       dp[i][j]  = 0
    end
end

dp[1][ofs] = 1


for i = 1, t do
    for j = lb, ub do
        for k = 1, 6 do
            next = j + die[k]
            if next >= lb and next <= ub then
                dp[i+1][next+ofs] = (dp[i+1][next+ofs] + dp[i][j+ofs]) % mod
            end
        end
    end
end

ans = 0
for j = d, e do
    ans = (ans + dp[t+1][j+ofs]) % mod
end
print(ans)


