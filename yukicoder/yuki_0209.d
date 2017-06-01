import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

immutable int INF = 10^^9 + 10;

void solve() {
    auto N = readln.chomp.to!int;
    auto H = readln.split.map!(to!int).array;

    auto dp_left = new int[][](N, N + 1);
    foreach (i; 0..N)
        foreach (j; 0..N+1)
            dp_left[i][j] = j <= 1 ? 0 : INF;

    foreach (i; 0..N)
        foreach (j; 0..i)
            foreach (k; 1..N+1)
                if (dp_left[j][k-1] < H[i] - H[j])
                    dp_left[i][k] = min(dp_left[i][k], H[i] - H[j]);

    auto dp_right = new int[][](N, N + 1);
    foreach (i; 0..N)
        foreach (j; 0..N+1)
            dp_right[i][j] = j <= 1 ? 0 : INF;

    foreach (i; iota(N-1, -1, -1))
        foreach (j; iota(N-1, i, -1))
            foreach (k; 1..N+1)
                if (dp_right[j][k-1] < H[i] - H[j])
                    dp_right[i][k] = min(dp_right[i][k], H[i] - H[j]);


    int ans = 0;
    foreach (i; 0..N)
        foreach (j; 1..N+1)
            foreach (k; 1..N+1)
                if (dp_left[i][j] != INF && dp_right[i][k] != INF)
                    ans = max(ans, j + k - 1);
    ans.writeln;
}

void main() {
    auto T = readln.chomp.to!int;
    while (T--) solve;
}

