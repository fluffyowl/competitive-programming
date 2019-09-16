import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;

    auto dp = new long[](N+1);
    dp[0] = 1;

    foreach (i; 0..N) {
        if (i + 2 <= N) {
            dp[i+2] += dp[i];
        }
        dp[i+1] += dp[i];
    }

    dp[N].writeln;
}

