import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

int INF = 1 << 29;

bool isDigit(char c) {
    return c - '0' >= 0 && c - '9' <= 9;
}

void main() {
    auto K = readln.chomp.to!int;
    auto S = readln.chomp;
    auto N = S.length.to!int;

    auto mem = new Tuple!(int, int)[][][](N, N, K + 1); // (min, max)
    foreach (i; 0..N) foreach (j; 0..N) fill(mem[i][j], tuple(INF, INF));
    
    Tuple!(int, int) dfs(int l, int r, int k) {
        if (mem[l][r][k][0] != INF) return mem[l][r][k];

        int L = r - l + 1;
        
        if (L % 2 == 0) {
            return tuple(-INF, -INF);
        } else if (L == 1) {
            if (k > 0) return tuple(0, 9);
            else if (S[l].isDigit) return tuple(S[l] - '0', S[l] - '0');
            else return tuple(-INF, -INF);
        } else {
            if (k == 0 && S[r].isDigit) return tuple(-INF, -INF);
            int mn = INF;
            int mx = -INF;
            foreach (kk; max(0, k-1)..k+1) {
                char[] op;
                if (kk == k) {
                    if (S[r] == '+') op = ['+'];
                    else if (S[r] == '-') op = ['-'];
                    else continue;
                } else {
                    op = ['+', '-'];
                }

                for (int i = l; i < r; i += 2) {
                    foreach (j; 0..kk+1) {
                        auto t1 = dfs(l, i, j);
                        auto t2 = dfs(i + 1, r - 1, kk - j);
                        if (t1[0] == -INF || t2[0] == -INF) continue;
                        foreach (opp; op) {
                            if (opp == '+') {
                                mn = min(mn, t1[0] + t2[0]);
                                mx = max(mx, t1[1] + t2[1]);
                            } else {
                                mn = min(mn, t1[0] - t2[1]);
                                mx = max(mx, t1[1] - t2[0]);
                            }
                        }
                    }
                }
            }

            mem[l][r][k] = mn == INF ? tuple(-INF, -INF) : tuple(mn, mx);
            return mem[l][r][k];
        }
    }

    auto ans = dfs(0, N - 1, K);
    if (ans[0] == -INF) writeln("NG");
    else {
        writeln("OK");
        writeln(ans[1]);
    }
}
