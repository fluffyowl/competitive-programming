import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new Tuple!(int, long)[][](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1] ~= tuple(s[1]-1, s[2].to!long);
        G[s[1]-1] ~= tuple(s[0]-1, s[2].to!long);
    }

    auto V = new Tuple!(long, long)[](N);
    fill(V, tuple(INF, INF));

    void dfs(int n, long a, long b) {
        if (V[n][0] != INF) return;
        V[n] = tuple(a, b);
        foreach (to; G[n]) {
            auto m = to[0];
            auto S = to[1];
            if (V[m][0] != INF) continue;
            dfs(m, -1*a, S-b);
        }
    }

    dfs(0, 1, 0);

    auto ans = INF;
    auto X = INF;

    foreach (i; 0..N) {
        long a1 = V[i][0];
        long b1 = V[i][1];
        foreach (e; G[i]) {
            int j = e[0];
            long S = e[1];
            long a2 = V[j][0];
            long b2 = V[j][1];
            if (a1 != a2) {
                if (b1 + b2 != S) {
                    writeln(0);
                    return;
                }
            } else if (a1 == 1) {
                long c = S - b1 - b2;
                if (c % 2 || c < 0) {
                    writeln(0);
                    return;
                }
                auto x = c / 2;
                if (X == INF || X == x) {
                    X = x, ans = 1;
                } else {
                    writeln(0);
                    return;
                }
            } else {
                long c = S - b1 - b2;
                if (c % 2 || c > 0) {
                    writeln(0);
                    return;
                }
                auto x = -c / 2;
                if (X == INF || X == x) {
                    X = x, ans = 1;
                } else {
                    writeln(0);
                    return;
                }
            }
        }
    }

    long lo = 1;
    long hi = INF;

    foreach (i; 0..N) {
        long b = V[i][1];
        if (V[i][0] == 1 && b < 0) {
            lo = max(lo, -b + 1);
        } else if (V[i][0] == -1 && b > 0) {
            hi = min(hi, b - 1);
        }
    }

    ans = min(ans, hi - lo + 1);
    ans = max(0, ans);
    ans.writeln;
}
