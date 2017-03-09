import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split;

    auto dp = new long[][](N, 3);
    dp[0][0] = A[0].to!long;
    dp[0][1] = dp[0][2] = - (10L^^15);


    foreach (i; 1..N) {
        auto sign = A[i*2-1];
        auto num  = A[i*2].to!long;
        if (sign == "+") {
            dp[i][0] = max(dp[i-1][0] + num, dp[i-1][1] - num, dp[i-1][2] + num);
            dp[i][1] = max(dp[i-1][1] - num, dp[i-1][2] + num);
            dp[i][2] = dp[i-1][2] + num;
        }
        else {
            dp[i][0] = max(dp[i-1][0] - num, dp[i-1][1] + num, dp[i-1][2] - num);
            dp[i][1] = max(dp[i-1][0] - num, dp[i-1][1] + num, dp[i-1][2] - num);
            dp[i][2] = max(dp[i-1][1] + num, dp[i-1][2] - num);
        }
    }

    dp[N-1].reduce!(max).writeln;
    
}
