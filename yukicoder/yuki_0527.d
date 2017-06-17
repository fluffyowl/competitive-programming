import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

alias Tuple!(int, "v", int, "w") Knap;

void main() {
    auto N = readln.chomp.to!int;
    auto K = new Knap[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!int);
        K[i] = Knap(s[0], s[1]);
    }
    auto V = readln.chomp.to!int;


    K.sort!"a.w < b.w"();

    auto dp = new int[][](N, 10^^5+1);
    dp[0][K[0].w] = K[0].v;

    foreach (i; 1..N) {
        foreach (k; 0..10^^5+1) {
            dp[i][k] = max(dp[i][k], dp[i-1][k]);
            if (k + K[i].w < 10^^5+1)
                dp[i][k+K[i].w] = max(dp[i][k+K[i].w], dp[i-1][k] + K[i].v);
        }
        dp[i][K[i].w] = max(dp[i][K[i].w], K[i].v);
    }

    foreach (j; 0..10^^5) dp[N-1][j+1] = max(dp[N-1][j], dp[N-1][j+1]);

    int minv = 1 << 29;
    int maxv = 0;
    foreach (j; 0..10^^5+1) {
        if (dp[N-1][j] == V) minv = min(minv, j), maxv = max(maxv, j);
    }

    if (K.map!(k => k.v).sum == V) maxv = -1;
    writeln(max(minv, 1));
    writeln(maxv == -1 ? "inf" : maxv.to!string);
}

