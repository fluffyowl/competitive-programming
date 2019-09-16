import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1].to!long;
    auto AB = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    long calc(int i) {
        long a = AB[i][0], b = AB[i][1];
        if (a >= 0 && b >= 0) {
            return a * (M - 1) + max(a, b);          
        } else if (a < 0 && b >= 0) {
            return b;
        } else if (a >= 0 && b < 0) {
            return a * M;
        } else {
            return max(a * M, b);
        }
    }

    auto dp = new long[][](N, 2);
    foreach (i; 0..N) dp[i][] = - (1L << 59);
    dp[0][0] = calc(0);

    foreach (i; 0..N-1) {       
        long a = AB[i+1][0], b = AB[i+1][1];

        dp[i+1][0] = max(dp[i+1][0], dp[i][0] + calc(i+1));
        dp[i+1][1] = max(dp[i+1][1], dp[i][0] + max(a, b));
        dp[i+1][1] = max(dp[i+1][1], dp[i][1] + max(a, b));
    }

    dp.map!(d => d.reduce!max).reduce!max.writeln;
}
