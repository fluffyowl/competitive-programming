import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {

    auto BCD = readln.split.map!(to!int).array.sort();
    auto N   = readln.chomp.to!int;
    auto E   = readln.split.map!(to!int).array.sort();

    auto dp = new int[][](N, 4);

    if (E[0] >= BCD[0])
        dp[0][0] = 1, dp[0][1] = 1;
    else
        dp[0][0] = 2;

    foreach (i; 1..N) {
        if (E[i] >= BCD[2]) {
            dp[i][3] = dp[i-1][2] + dp[i-1][3] * 2;
            dp[i][2] = dp[i-1][1] + dp[i-1][2];
            dp[i][1] = dp[i-1][0] + dp[i-1][1];
            dp[i][0] = dp[i-1][0];
        }
        else if (E[i] >= BCD[1]) {
            dp[i][3] = dp[i-1][3] * 2;
            dp[i][2] = dp[i-1][1] + dp[i-1][2] * 2;
            dp[i][1] = dp[i-1][0] + dp[i-1][1];
            dp[i][0] = dp[i-1][0];
        }
        else if (E[i] >= BCD[0]) {
            dp[i][3] = dp[i-1][3] * 2;
            dp[i][2] = dp[i-1][2] * 2;
            dp[i][1] = dp[i-1][0] + dp[i-1][1] * 2;
            dp[i][0] = dp[i-1][0];
        }
        else {
            dp[i][3] = dp[i-1][3] * 2;
            dp[i][2] = dp[i-1][2] * 2;
            dp[i][1] = dp[i-1][1] * 2;
            dp[i][0] = dp[i-1][0] * 2;
        }
    }

    dp[N-1][3].writeln;

}

