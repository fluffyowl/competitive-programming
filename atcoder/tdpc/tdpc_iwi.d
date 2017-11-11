import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto dp = new int[][](N + 1, N + 1);

    foreach (len; 3..N+1) {
        foreach (l; 0..N-len+1) {
            int r = l + len;
            int nlen = len - 3;
            foreach (a; l..r)
                dp[l][r] = max(dp[l][r], dp[l][a] + dp[a][r]);
            foreach (a; l..l+len-nlen+1) {
                int b = a + nlen;
                if ((b - a) % 3 == 0 && dp[a][b] == (b - a) / 3)
                    dp[l][r] = max(dp[l][r], dp[a][b] + (S[l..a] ~ S[b..r] == "iwi"));
            }
        }
    }

    dp[0][N].writeln;
}
