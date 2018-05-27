import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2];
    auto A = readln.split.map!(to!long).array;

    auto dp = new long[][](2, N);
    dp[0] = A.dup;
    int cur = 0, tar = 1;

    foreach (i; 1..K) {
        dp[tar].fill(-INF);
        auto q = new long[](2*N+10);
        int x = N/2;
        int y = N/2;
        foreach (j; i..N) {
            int a = j - M - 1;
            int b = j - 1;
            if (a >= 0 && x < y && q[x] == a) x++;
            while (x < y && dp[cur][q[y-1]] < dp[cur][b]) y--;
            q[y++] = b;
            dp[tar][j] = dp[cur][q[x]] + A[j] * (i + 1);
        }
        swap(cur, tar);
    }

    dp[cur].reduce!max.writeln;
}
