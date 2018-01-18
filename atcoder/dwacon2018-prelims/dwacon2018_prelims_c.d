import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9+7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = readln.split.map!(to!int).array;
    auto B = readln.split.map!(to!int).array;

    long calc(int n, int[] a, int kills) {
        auto same = new long[](n);
        same[n-1] = 1;

        for (int i = n-2; i >= 0; --i) {
            if (a[i] == a[i+1]) same[i] = same[i+1]+1;
            else same[i] = 1;
        }

        auto dp = new long[][](n+1, kills+1);
        dp[0][kills] = 1;

        foreach (i; 0..n) {
            foreach (j; 0..kills+1) {
                if (dp[i][j] == 0) continue;
                for (int x = 0; x <= j; x += same[i]) {
                    dp[i+1][j-x] += dp[i][j];
                    dp[i+1][j-x] %= MOD;
                }
            }
        }

        return dp[n][0];
    }

    long ans = calc(N, A, B.sum) * calc(M, B, A.sum) % MOD;
    ans.writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable long MOD = 10^^9+7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = readln.split.map!(to!int).array;
    auto B = readln.split.map!(to!int).array;

    long calc(int n, int[] a, int kills) {
        auto same = new long[](n);
        same[n-1] = 1;

        for (int i = n-2; i >= 0; --i) {
            if (a[i] == a[i+1]) same[i] = same[i+1]+1;
            else same[i] = 1;
        }

        auto dp = new long[][](n+1, kills+1);
        dp[0][kills] = 1;

        foreach (i; 0..n) {
            foreach (j; 0..kills+1) {
                if (dp[i][j] == 0) continue;
                for (int x = 0; x <= j; x += same[i]) {
                    dp[i+1][j-x] += dp[i][j];
                    dp[i+1][j-x] %= MOD;
                }
            }
        }

        return dp[n][0];
    }

    long ans = calc(N, A, B.sum) * calc(M, B, A.sum) % MOD;
    ans.writeln;
}
