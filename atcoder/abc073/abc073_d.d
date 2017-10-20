import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

alias Tuple!(int, "a", int, "b") Score;
const int INF = 1 << 29;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2];
    auto R = readln.split.map!(x => x.to!int-1).array;
    auto edges = new Tuple!(int, int)[][](N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        edges[s[0] - 1] ~= tuple(s[1] - 1, s[2]);
        edges[s[1] - 1] ~= tuple(s[0] - 1, s[2]);
    }

    auto d = new int[][](N, N);
    foreach (i; 0..N)
        foreach (j; 0..N)
            d[i][j] = i == j ? 0 : INF;

    foreach (i; 0..N)
        foreach (j; edges[i]) {
            d[i][j[0]] = j[1];
        }

    for (int i = 0; i < N; i++)      // 経由する頂点
        for (int j = 0; j < N; j++)    // 開始頂点
            for (int k = 0; k < N; k++)  // 終端
                d[j][k] = min(d[j][k], d[j][i] + d[i][k]);


    int ans = 1 << 29;
    R.sort();
    do {
        int tmp = 0;
        foreach (i; 0..K-1)
            tmp += d[R[i]][R[i+1]];
        ans = min(ans, tmp);
    } while (nextPermutation(R));

    ans.writeln;
}
