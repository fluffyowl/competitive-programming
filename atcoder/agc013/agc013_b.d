import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

int N, M;
int[][] edges;

int root = 0, timer = 1;
int[] prenum, lowest, parent;
bool[] visited, is_kansetsu;

int s;
int end1, end2;
int[] required;

void dfs(int u, int prev) {
    prenum[u] = timer;
    lowest[u] = timer;
    timer++;

    visited[u] = true;

    foreach (v; edges[u]) {
        if (!visited[v]) {
            parent[v] = u;
            dfs(v, u);
            lowest[u] = min(lowest[u], lowest[v]);
        }
        else if (v != prev) {
            lowest[u] = min(lowest[u], prenum[v]);
        }
    }
}


bool dfs2(int n, int prev) {
    parent[n] = prev;

    if (visited[n]) return false;
    visited[n] = true;
    int cnt = 0;

    foreach (m; edges[n]) {
        if (visited[m]) continue;
        auto ret = dfs2(m, n);
        if (ret) return true;
        cnt += 1;
    }

    if (cnt == 0) {
        end1 = n;
        return true;
    }
    visited[n] = false;
    return false;
}

void main() {
    auto S = readln.split.map!(to!int);
    N = S[0];
    M = S[1];
    edges = new int[][](N);
    foreach (i; 0..M) {
        S = readln.split.map!(to!int);
        edges[S[0]-1] ~= S[1] - 1;
        edges[S[1]-1] ~= S[0] - 1;
    }

    prenum = new int[](N);
    lowest = new int[](N);
    parent = new int[](N);
    visited = new bool[](N);
    dfs(root, -1);

    is_kansetsu = new bool[](N);
    int cnt = 0;
    foreach (i; 0..N) {
        if (i == root || parent[i] == root) continue;
        if (prenum[parent[i]] <= lowest[i]) is_kansetsu[parent[i]] = true;
        if (parent[i] == root) cnt += 1;
    }
    if (cnt >= 2) is_kansetsu[root] = true;

    foreach (i; 0..N) {
        if (!is_kansetsu[i]) {
            s = i;
            break;
        }
    }

    parent = new int[](N);
    visited = new bool[](N);
    dfs2(s, -1);
    end2 = end1;
    visited[s] = false;
    dfs2(s, -1);

    int[] ans2;
    int[] ans1;
    while (end2 != -1) {
        ans2 ~= end2;
        end2 = parent[end2];
    }
    while (end1 != s) {
        ans1 ~= end1;
        end1 = parent[end1];
    }

    ans1.reverse();
    int[] ans = ans2 ~ ans1;
    ans.length.writeln;
    ans.map!(a => (a+1).to!string).join(" ").writeln;
}
