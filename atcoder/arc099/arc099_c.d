import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

int INF = 1 << 29;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto G = new int[][](N, N);
    foreach (i; 0..N) G[i][i] = true;
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G[s[0]-1][s[1]-1] = true;
        G[s[1]-1][s[0]-1] = true;
    }
    auto D = new int[](N);
    fill(D, -1);

    Tuple!(int, int) dfs(int n, int parity) {
        if (D[n] == parity)
            return tuple(0, 0);
        if (D[n] != -1 && D[n] != parity)
            return tuple(-INF, -INF);
        D[n] = parity;
        auto ret = tuple(0, 0);
        ret[0] += parity == 0 ? 1 : 0;
        ret[1] += parity == 1 ? 1 : 0;
        foreach (m; 0..N) {
            if (!G[n][m]) {
                auto t = dfs(m, parity^1);
                if (t[0] < 0)
                    return tuple(-INF, -INF);
                ret[0] += t[0];
                ret[1] += t[1];
            }
        }
        return ret;
    }

    int[] V, W;
    foreach (i; 0..N) {
        if (D[i] == -1) {
            auto t = dfs(i, 0);
            if (t[0] < 0) {
                writeln(-1);
                return;
            }
            V ~= t[0];
            W ~= t[1];
        }
    }

    immutable int MAX = 1000;
    auto dp = new bool[][](N+1, N+1);
    dp[0][0] = true;

    foreach (i; 0..V.length) 
        foreach_reverse (j; 0..N+1) 
            foreach_reverse (k; 0..N+1) 
                if (dp[j][k])
                    dp[j+V[i]][k+W[i]] = true, dp[j+W[i]][k+V[i]] = true;

    int ans = INF;
    foreach (i; 0..N+1) {
        int j = N - i;
        if (dp[i][j]) {
            ans = min(ans, i*(i-1)/2+j*(j-1)/2);
        }
    }
    ans.writeln;
}
