import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

long solve(string N, long M) {
    long ans = 0;
    auto K = N.length.to!int;

    auto dp = new long[][](K/2+K%2+1, 2);
    dp[0][0] = 1;

    foreach (i; 0..K/2+K%2) {
        foreach (j; 0..2) {
            int d = j ? 9 : N[i] - '0';
            foreach (k; 0..d+1) {
                if (i == 0 && k == 0) continue;
                (dp[i+1][j || (k < N[i] - '0')] += dp[i][j]) %= M;
            }
        }
    }

    foreach (j; 0..2) {
        (ans += dp[K/2+K%2][j]) %= M;
    }

    string NN = "";
    foreach (i; 0..N.length) if (i < K / 2 + K % 2) NN ~= N[i]; else NN ~= N[$-i-1];
    if (NN > N) ans = (ans - 1 + M) % M;

    long tmp = 9;
    foreach (k; 1..K) {
        if (k >= 3 && k % 2 == 1) tmp = tmp * 10 % M;
        ans = (ans + tmp) % M;
    }


    return ans;
}


void main() {

    auto N = readln.chomp;
    solve(N, 10^^9).writeln;
    solve(N, 10^^9+7).writeln;
}

