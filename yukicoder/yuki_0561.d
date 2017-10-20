import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0].to!int;
    auto D = s[1];
    auto TK = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    auto dp = new long[][](N+1, 2);
    dp[0][1] = - (1L << 59);

    foreach (i; 0..N) {
        dp[i + 1][0] = max(dp[i][0] + TK[i][0], dp[i][1] + TK[i][0] - D);
        dp[i + 1][1] = max(dp[i][1] + TK[i][1], dp[i][0] + TK[i][1] - D);
    }

    writeln(max(dp[N][0], dp[N][1]));
}

