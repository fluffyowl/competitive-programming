import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;


void main() {
    immutable int INF = 1 << 29;

    auto N = readln.chomp.to!int + 2;
    auto S = '0' ~ readln.chomp ~ '0';
    auto dp = new int[](N);
    dp.fill(-INF);
    dp[0] = 0;

    foreach (i; 1..N-1) {
        dp[i] = max(dp[i], dp[i-1]);
        if (S[i-1..i+2] != "101") continue;
        for (int p = i - 1; p >= 0 && S[p] == '1'; --p) {
            dp[i+1] = max(dp[i+1], dp[p-1] + i - p);
        }
        for (int p = i + 1; p < N && S[p] == '1'; ++p) {
            dp[p] = max(dp[p], dp[i-2] + p - i);
        }
    }

    dp[N-2].writeln;
}
