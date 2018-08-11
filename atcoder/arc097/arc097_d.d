import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

int N;
int[][] G;
string C;
int root;

void input() {
    auto n = readln.chomp.to!int;
    auto g = new int[][](n);
    foreach (_; 0..n-1) {
        auto s = readln.split.map!(to!int);
        g[s[0]-1] ~= s[1]-1;
        g[s[1]-1] ~= s[0]-1;
    }
    auto c = readln.chomp;

    root = -1;
    foreach (i; 0..n) if (c[i] == 'W') root = i;
    
    if (root == -1) {
        N = 0;
        return;
    }

    
    auto use = new bool[](n);
    use.fill(true);

    int dfs(int u, int p) {
        int ret = c[u] == 'W';
        foreach (v; g[u]) {
            if (v == p) continue;
            int tmp = dfs(v, u);
            if (tmp == 0) use[v] = false;
            ret += tmp;
        }
        return ret;
    }
    dfs(root, -1);

    N = use.sum;
    G = new int[][](N);
    auto comp = new int[](n);
    comp.fill(-1);

    for (int i = 0, cnt = 0; i < n; ++i) {
        if (use[i]) {
            comp[i] = cnt++;
            C ~= c[i];
        }
    }

    foreach (i; 0..n) {
        if (!use[i]) continue;
        foreach (j; g[i]) {
            if (!use[j]) continue;
            G[comp[i]] ~= comp[j];
        }
    }

    root = comp[root];
}

void main() {
    input();
    auto D = C.map!(c => c == 'W' ? 1 : 0).array;
    
    if (N <= 1) {
        N.writeln;
        return;
    }
    
    void dfs(int n, int p) {
        D[n] ^= 1;
        foreach (m; G[n]) if (m != p) dfs(m, n), D[n] ^= 1;
    }

    Tuple!(int, int) farest(int n, int p, int d) {
        int nd = d + D[n];
        auto ret = tuple(nd, n);
        foreach (m; G[n]) if (m != p) ret = max(ret, farest(m, n, nd));
        return ret;
    }

    D[root] ^= 1;
    dfs(root, -1);

    auto s = farest(root, -1, 0);
    auto t = farest(s[1], -1, 0);
    auto u = s[1];
    auto v = t[1];
    
    int ans = (N - 1) * 2;
    foreach (i; 0..N) if (G[i].length > 1 && D[i]) ans += 1;
    ans -= t[0] * 2;
    
    ans.writeln;
}
