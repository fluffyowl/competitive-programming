import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

int N, K;
int[][] edge;
bool[] visited;

void dfs(int n, int prev, int d) {
    visited[n] = true;
    if (d == 0) return;

    foreach (m; edge[n]) {
        if (m == prev) continue;
        dfs(m, n, d-1);
    }
}


void main() {
    auto s = readln.split.map!(to!int).array;
    N = s[0];
    K = s[1];
    visited = new bool[](N);
    edge = new int[][](N);
    foreach (i; 0..N-1) {
        s = readln.split.map!(to!int).array;
        edge[s[0]-1] ~= s[1]-1;
        edge[s[1]-1] ~= s[0]-1;
    }

    int ans = 1 << 29;
    if (K % 2 == 0) {
        foreach (i; 0..N) { // 各頂点を木の中心と仮定
            fill(visited, false);
            dfs(i, -1, K/2);
            ans = min(ans, N-visited.sum);
        }
    }
    else {
        foreach (i; 0..N) {
            foreach (j; edge[i]) {
                if (j < i) continue;
                fill(visited, false);
                dfs(i, -1, K/2);
                dfs(j, -1, K/2);
                ans = min(ans, N-visited.sum);
            }
        }
    }

    writeln(K == 1 ? N-2 : ans);
}
