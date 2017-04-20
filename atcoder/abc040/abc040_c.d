import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int);

    auto dp = new int[](N);
    dp[0] = 0;
    dp[1] = abs(A[0] - A[1]);
    foreach (i; 2..N) {
        auto d1 = abs(A[i] - A[i-1]) + dp[i-1];
        auto d2 = abs(A[i] - A[i-2]) + dp[i-2];
        dp[i] = min(d1, d2);
    }

    dp[N-1].writeln;
}
