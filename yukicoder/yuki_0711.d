import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 60;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    long[] B;
    int ans = 0;

    foreach (i; 0..N) {
        if (A[i] - i > 0) {
            B ~= A[i] - i;
        } else {
            ans += 1;
        }
    }
    
    N = B.length.to!int;
    auto dp = new long[](N+1);
    fill(dp, INF);
    dp[0] = -1;

    foreach (i; 0..N) {
        int lb = dp.assumeSorted.lowerBound(B[i]+1).length.to!int;
        dp[lb] = B[i];
    }


    int tmp = 0;
    foreach (i; 0..N+1) if (dp[i] < INF) tmp = N - i;
    ans += tmp;

    ans.writeln;
}

