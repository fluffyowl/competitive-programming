import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto X = new int[](N+1);
    int[][int] Y;
    X[0] = 0;
    Y[0] = [0];
    foreach (i; 0..N) {
        int c = S[i] - 'a';
        X[i+1] = X[i] ^ (1 << c);
        Y[X[i+1]] ~= i+1;
    }


    auto dp = new int[](N+1);
    dp.fill(1 << 29);
    dp[0] = 0;
    int[int] used;

    foreach (i; 0..N) {
        foreach (j; 0..26) {
            int next = X[i] ^ (1 << j);
            if (next in Y && (!(next in used) || used[next] > dp[i])) {
                used[next] = dp[i];
                foreach (m; Y[next]) {
                    dp[m] = min(dp[m], dp[i]+1);
                }
            }
        }

        if (X[i] in Y && (!(X[i] in used) || used[X[i]] > dp[i])) {
            used[X[i]] = dp[i];
            foreach (m; Y[X[i]]) {
                dp[m] = min(dp[m], dp[i]+1);
            }
        }
    }

    dp[N].writeln;
}
