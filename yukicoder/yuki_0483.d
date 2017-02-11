import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


immutable int MAX = 120;
alias Tuple!(int, "a", int, "b", int, "c", int, "d") Match;
int N;
Match[] M;
int[][][] B;
bool[] used;
int[][] adj;
bool[][] P;


bool dfs(int x) {
    used[x] = true;
    auto m = M[x];
    if (m.a == m.c) {
        if (!P[m.a][m.b]) {
            P[m.a][m.b] = true;
            bool ret = true;
            foreach (y; adj[x]) {
                if (used[y]) continue;
                if (!dfs(y)) {
                    ret = false;
                    break;
                }
            }
            if (ret) return true;
            P[m.a][m.b] = false;
        }

        if (!P[m.a][m.d]) {
            P[m.a][m.d] = true;
            bool ret = true;
            foreach (y; adj[x]) {
                if (used[y]) continue;
                if (!dfs(y)) {
                    ret = false;
                    break;
                }
            }
            if (ret) return true;
            P[m.a][m.d] = false;
        }
    }

    else {
        if (!P[m.a][m.b]) {
            P[m.a][m.b] = true;
            bool ret = true;
            foreach (y; adj[x]) {
                if (used[y]) continue;
                if (!dfs(y)) {
                    ret = false;
                    break;
                }
            }
            if (ret) return true;
            P[m.a][m.b] = false;
        }

        if (!P[m.c][m.b]) {
            P[m.c][m.b] = true;
            bool ret = true;
            foreach (y; adj[x]) {
                if (used[y]) continue;
                if (!dfs(y)) {
                    ret = false;
                    break;
                }
            }
            if (ret) return true;
            P[m.c][m.b] = false;
        }
    }

    used[x] = false;
    return false;
}

void main() {
    N = readln.chomp.to!int;
    M = new Match[](N);
    B = new int[][][](MAX, MAX);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!int).array;
        M[i] = Match(s[0], s[1], s[2], s[3]);
        if (s[0] == s[2]) {
            B[s[0]][s[1]] ~= i;
            B[s[0]][s[3]] ~= i;
        } else {
            B[s[0]][s[1]] ~= i;
            B[s[2]][s[1]] ~= i;
        }
    }

    adj = new int[][](N);
    foreach (i; 0..MAX) {
        foreach (j; 0..MAX) {
            auto x = B[i][j].length;
            foreach (a; B[i][j]) {
                foreach (b; B[i][j]) {
                    if (a != b) {
                        adj[a] ~= b;
                    }
                }
            }
        }
    }

    used = new bool[](N);
    foreach (i; 0..N) {
        if (used[i]) continue;
        P = new bool[][](MAX, MAX);
        if (!dfs(i)) {
            writeln("NO");
            return;
        }
    }


    writeln("YES");
}

