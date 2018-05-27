import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    alias Point = Tuple!(int, "r", int, "c");
    immutable long INF = 1L << 60;

    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;

    int gr, gc;
    Point[] P;
    int p = 0;
    auto R = new int[][](H);
    auto C = new int[][](W);

    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (A[i][j] != '.') {
                P ~= Point(i, j);
                R[i] ~= p;
                C[j] ~= p;
                p += 1;
                if (A[i][j] == 'G') gr = i, gc = j;
            }
        }
    }

    auto G = new int[][](p);

    foreach (i; 0..H) {
        foreach (j; 0..R[i].length.to!int-1) {
            G[R[i][j]] ~= R[i][j+1];
            G[R[i][j+1]] ~= R[i][j];
        }
    }

    foreach (i; 0..W) {
        foreach (j; 0..C[i].length.to!int-1) {
            G[C[i][j]] ~= C[i][j+1];
            G[C[i][j+1]] ~= C[i][j];
        }
    }

    auto dp = new long[][](p, 3000);
    foreach (i; 0..p) if (P[i].r != gr || P[i].c != gc) dp[i].fill(INF);

    foreach_reverse (j; 0..2999)
        foreach (n; 0..p)
            foreach (m; G[n])
                dp[n][j] = min(dp[n][j], dp[m][j+1] + abs(P[n].r - P[m].r) * j + abs(P[n].c - P[m].c) * j);

    auto ans = new long[][](H, W);
    foreach (i; 0..H) ans[i].fill(INF);
    auto hoge = new long[][](H, W);

    foreach (i; 0..p) {
        int r = P[i].r;
        int c = P[i].c;
        ans[r][c] = dp[i][1];
        hoge[r][c] = dp[i][2];
    }

    foreach (i; 0..H) {
        long tmp = INF;
        foreach (j; 0..W) {
            if (A[i][j] == '.') {
                ans[i][j] = min(ans[i][j], tmp);
            } else if (A[i][j] != '.') {
                tmp = hoge[i][j];
            }
            if (tmp != INF) tmp += 1;
        }
        tmp = INF;
        foreach_reverse (j; 0..W) {
            if (A[i][j] == '.') {
                ans[i][j] = min(ans[i][j], tmp);
            } else if (A[i][j] != '.') {
                tmp = hoge[i][j];
            }
            if (tmp != INF) tmp += 1;
        }
    }

    foreach (j; 0..W) {
        long tmp = INF;
        foreach (i; 0..H) {
            if (A[i][j] == '.') {
                ans[i][j] = min(ans[i][j], tmp);
            } else if (A[i][j] != '.') {
                tmp = hoge[i][j];
            }
            if (tmp != INF) tmp += 1;
        }
        tmp = INF;
        foreach_reverse (i; 0..H) {
            if (A[i][j] == '.') {
                ans[i][j] = min(ans[i][j], tmp);
            } else if (A[i][j] != '.') {
                tmp = hoge[i][j];
            }
            if (tmp != -1) tmp += 1;
        }
    }


    foreach (i; 0..H) ans[i].map!(a => a >= INF ? -1 : a).map!(a => a.to!string).join(" ").writeln;
}
