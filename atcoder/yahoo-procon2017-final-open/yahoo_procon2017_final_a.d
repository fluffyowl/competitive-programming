import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable int INF = 1 << 29;
immutable string yahoo = "yahoo";

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    
    auto dp = new int[][](N+1, 5);
    foreach (i; 0..N+1) dp[i].fill(INF);
    foreach (j; 0..5) dp[0][j] = j;

    foreach (i; 0..N) {
        foreach (j; 0..5) {
            // 変更
            dp[i+1][(j+1)%5] = min(dp[i+1][(j+1)%5], dp[i][j] + (S[i] != yahoo[j]));
            // 削除
            dp[i+1][j] = min(dp[i+1][j], dp[i][j] + 1);
        }
        // 挿入
        foreach (j; 0..10) {
            dp[i+1][(j+1)%5] = min(dp[i+1][(j+1)%5], dp[i+1][j%5]+1);
        }
    }

    dp[N][0].writeln;
}
