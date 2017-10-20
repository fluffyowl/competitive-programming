import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long INF = 10L ^^ 18 + 1000;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto K = readln.chomp.to!long;

    auto chars = new int[][](26, N);
    foreach (i; 0..26) {
        int tmp = -1;
        for (int j = N - 1; j >= 0; j--) {
            if (S[j] - 'a' == i) tmp = j;
            chars[i][j] = tmp;
        }
    }

    auto dp = new long[](N);
    fill(dp, 1);

    for (int i = N - 2; i >= 0; i--) {
        foreach (j; 0..26) {
            int m = chars[j][i + 1];
            if (m == -1) continue;
            if (dp[m] == INF) {
                dp[i] = INF;
                continue;
            }
            dp[i] += dp[m];
            if (dp[i] > INF || dp[i] <= 0) {
                dp[i] = INF;
                continue;
            }
        }
    }


    string ans = "";


    void dfs(int p, long acm) {
        if (acm == K) return;
        foreach (i; 0..26) {
            int m = chars[i][p];
            if (m == -1) continue;
            if (acm + dp[chars[i][m]] >= K) {
                ans ~= i.to!char + 'a';
                dfs(chars[i][m] + 1, acm + 1);
                return;
            }
            acm += dp[chars[i][m]];
        }
    }


    dfs(0, 0);
    if (ans == "") writeln("Eel");
    else writeln(ans);
}
