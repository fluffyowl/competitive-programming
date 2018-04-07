import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;

    auto dp1 = new int[][](N, N);
    auto dp2 = new int[][](N, N);
    foreach (i; 0..N) dp1[i][i] = dp2[i][i] = 1;

    foreach (len; 2..N+1) {
        foreach (l; 0..N-len+1) {
            int r = l + len - 1;
            dp1[l][r] = dp1[l][r-1];
            if (A[l] < A[r]) dp1[l][r] = max(dp1[l][r], dp2[l+1][r] + 1);
            dp2[l][r] = dp2[l+1][r];
            if (A[l] > A[r]) dp2[l][r] = max(dp2[l][r], dp1[l][r-1] + 1);
        } 
    }

    int ans = 0;
    foreach (i; 0..N) foreach (j; 0..N) ans = max(ans, dp1[i][j], dp2[i][j]);
    ans.writeln;
}

