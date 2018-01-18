import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;


void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto dp = new int[][](N, 2); // 2, 5
    if (S[0] == '2' || S[0] == '?') dp[0][0] = 1;

    foreach (i; 1..N) {
        if (S[i] == '2') {
            dp[i][0] = dp[i-1][1] + 1;
        } else if (S[i] == '5') {
            if (dp[i-1][0] > 0) dp[i][1] = dp[i-1][0] + 1;
        } else if (S[i] == '?') {
            dp[i][0] = dp[i-1][1] + 1;
            if (dp[i-1][0] > 0) dp[i][1] = dp[i-1][0] + 1;
        }
    }

    dp.map!(d => d[1]).reduce!max.writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;


void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto dp = new int[][](N, 2); // 2, 5
    if (S[0] == '2' || S[0] == '?') dp[0][0] = 1;

    foreach (i; 1..N) {
        if (S[i] == '2') {
            dp[i][0] = dp[i-1][1] + 1;
        } else if (S[i] == '5') {
            if (dp[i-1][0] > 0) dp[i][1] = dp[i-1][0] + 1;
        } else if (S[i] == '?') {
            dp[i][0] = dp[i-1][1] + 1;
            if (dp[i-1][0] > 0) dp[i][1] = dp[i-1][0] + 1;
        }
    }

    dp.map!(d => d[1]).reduce!max.writeln;
}
