import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, core.stdc.string;

immutable long MOD = 10^^9 + 7;
immutable int MAX = 1000;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    while (A.length < MAX) A ~= 0;

    auto dp = new long[][](MAX+1, MAX); // iをj個作った
    dp[0][0] = 1;
    long ans = 0;

    foreach (i; 0..MAX) {
        foreach (j; 0..MAX) {
            foreach (k; 0..A[i]+1) {
                if (j + k >= MAX) continue;
                if (j + k == 1) (ans += dp[i][j]) %= MOD;
                if ((j + k) % 2 == 0) (dp[i+1][(j+k)/2] += dp[i][j]) %= MOD;
            }
        }
    }

    //dp.each!writeln;
    ans.writeln;
}
