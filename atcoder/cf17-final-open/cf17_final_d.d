import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const long INF = 1L << 59;

void main() {
    auto N = readln.chomp.to!int;
    auto HP = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    HP.sort!"a[0]+a[1] == b[0]+b[1] ? a[1] < b[1] : a[0]+a[1] < b[0]+b[1]"();
    //HP.sort();

    auto dp = new Tuple!(long, long)[][](2, N+1);
    foreach (i; 0..2) dp[i].fill(tuple(INF, INF));
    dp[0][0] = tuple(0L, INF);
    int cur = 0;
    int tar = 1;

    foreach (i; 0..N) {
        foreach (j; 0..N+1)
            dp[tar][j] = dp[cur][j];
        foreach (j; 0..N) {
            if (dp[cur][j][0] <= HP[i][0]) {
                long takasa = dp[cur][j][0]+HP[i][1];
                long seigen = min(dp[cur][j][1], HP[i][0]-dp[cur][j][0]);
                if (takasa < dp[tar][j+1][0] || (takasa == dp[tar][j+1][0] && seigen > dp[tar][j+1][1]))
                    dp[tar][j+1] = tuple(takasa, seigen);
            } else if (dp[cur][j][1] >= HP[i][1]) {
                long takasa = dp[cur][j][0]+HP[i][1];
                long seigen = dp[cur][j][1]-HP[i][1];
                if (takasa < dp[tar][j+1][0] || (takasa == dp[tar][j+1][0] && seigen > dp[tar][j+1][1]))
                    dp[tar][j+1] = tuple(takasa, seigen);
            }
        }

        cur ^= 1;
        tar ^= 1;
    }

    //dp.each!(d => d.each!(p => [p[0], p[1]].writeln));

    int ans = 0;
    foreach (i; 0..2)
        foreach (j; 0..N+1)
            if (dp[i][j][0] < INF)
                ans = max(ans, j);
    ans.writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const long INF = 1L << 59;

void main() {
    auto N = readln.chomp.to!int;
    auto HP = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    HP.sort!"a[0]+a[1] == b[0]+b[1] ? a[1] < b[1] : a[0]+a[1] < b[0]+b[1]"();
    //HP.sort();

    auto dp = new Tuple!(long, long)[][](2, N+1);
    foreach (i; 0..2) dp[i].fill(tuple(INF, INF));
    dp[0][0] = tuple(0L, INF);
    int cur = 0;
    int tar = 1;

    foreach (i; 0..N) {
        foreach (j; 0..N+1)
            dp[tar][j] = dp[cur][j];
        foreach (j; 0..N) {
            if (dp[cur][j][0] <= HP[i][0]) {
                long takasa = dp[cur][j][0]+HP[i][1];
                long seigen = min(dp[cur][j][1], HP[i][0]-dp[cur][j][0]);
                if (takasa < dp[tar][j+1][0] || (takasa == dp[tar][j+1][0] && seigen > dp[tar][j+1][1]))
                    dp[tar][j+1] = tuple(takasa, seigen);
            } else if (dp[cur][j][1] >= HP[i][1]) {
                long takasa = dp[cur][j][0]+HP[i][1];
                long seigen = dp[cur][j][1]-HP[i][1];
                if (takasa < dp[tar][j+1][0] || (takasa == dp[tar][j+1][0] && seigen > dp[tar][j+1][1]))
                    dp[tar][j+1] = tuple(takasa, seigen);
            }
        }

        cur ^= 1;
        tar ^= 1;
    }

    //dp.each!(d => d.each!(p => [p[0], p[1]].writeln));

    int ans = 0;
    foreach (i; 0..2)
        foreach (j; 0..N+1)
            if (dp[i][j][0] < INF)
                ans = max(ans, j);
    ans.writeln;
}
