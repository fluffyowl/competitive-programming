import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto S = readln.chomp.map!(a => a == 'B').array;
    auto G = new int[][](N);
    auto cnt = new int[][](N, 2);
    auto deleted = new bool[](N);

    void dfs(int n) {
        if (deleted[n]) return;
        deleted[n] = true;
        foreach (m; G[n]) {
            if (deleted[m]) continue;
            cnt[m][S[n]] -= 1;
            if (cnt[m][S[n]] == 0) {
                dfs(m);
            }
        }
    }

    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        auto u = s[0] - 1;
        auto v = s[1] - 1;
        G[u] ~= v;
        G[v] ~= u;
        cnt[u][S[v]] += 1;
        cnt[v][S[u]] += 1;
    }

    foreach (i; 0..N) {
        if (!deleted[i] && (cnt[i][0] == 0 || cnt[i][1] == 0)) {
            dfs(i);
        }
    }

    writeln(deleted.all ? "No" : "Yes");
}
