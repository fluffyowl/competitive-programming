import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    const int[] dr4 = [-1, 1, 0, 0];
    const int[] dc4 = [0, 0, -1, 1];
    const int[] dr8 = [-1, -1, -1, 0, 0, 1, 1, 1];
    const int[] dc8 = [-1, 0, 1, -1, 1, -1, 0, 1];

    
    auto s = readln.split.map!(to!int);
    auto H = s[0] + 2;
    auto W = s[1] + 2;
    auto A = (H-2).iota.map!(_ => "." ~ readln.chomp ~ ".").array;
    A = '.'.repeat().take(W).to!string ~ A ~ '.'.repeat().take(W).to!string;

    auto uf = new UnionFind(H*W);
    auto used = new bool[][](H, W);

    void dfs(int r, int c, int sr, int sc) {
        if (used[r][c]) return;
        used[r][c] = true;
        uf.unite(r*W+c, sr*W+sc);
        foreach (i; 0..8) {
            int nr = r + dr8[i];
            int nc = c + dc8[i];
            if (nr < 0 || nr >= H || nc < 0 || nc >= W) continue;
            if (used[nr][nc] || A[nr][nc] == '.') continue;
            dfs(nr, nc, sr, sc);
        }
    }

    foreach (i; 0..H) foreach (j; 0..W) if (!used[i][j] && A[i][j] == 'x') dfs(i, j, i, j);

    int cnt = 0;
    auto node_map = new int[](H*W);
    node_map.fill(-1);
    foreach (i; 0..H*W) if (uf.table[i] < -1) node_map[i] = cnt++;
    foreach (i; 0..H*W) node_map[i] = node_map[uf.find(i)];

    if (cnt == 0) {
        writeln(0);
        return;
    }
    
    auto size = new int[](cnt);
    foreach (i; 0..H*W) if (uf.table[uf.find(i)] < -1) size[node_map[uf.find(i)]] = -uf.table[uf.find(i)];
    

    used = new bool[][](H, W);
    auto G = new int[][](cnt);
    auto G_set = new bool[int][](cnt);
    auto roots = new bool[](cnt);
    auto q = new BinaryHeap!(Array!(Tuple!(int, int, int, int)), "a[2] > b[2]");
    q.insert(tuple(0, 0, 1, -1));

    while (!q.empty) {
        auto t = q.front;
        q.removeFront;
        auto r = t[0];
        auto c = t[1];
        auto d = t[2];
        auto last = t[3];
        
        if (used[r][c]) continue;
        used[r][c] = true;

        int nd = d;
        int nlast = last;
        if (A[r][c] == 'x' && node_map[r*W+c] != last) {
            if (last != -1) {
                G_set[last][node_map[r*W+c]] = true;
                G_set[node_map[r*W+c]][last] = true;
            } else {
                roots[node_map[r*W+c]] = true;
            }
            nd += 1;
            nlast = node_map[r*W+c];
        }
        
        foreach (i; 0..4) {
            int nr = r + dr4[i];
            int nc = c + dc4[i];
            if (nr < 0 || nr >= H || nc < 0 || nc >= W) continue;
            if (used[nr][nc]) continue;
            q.insert(tuple(nr, nc, nd, nlast));
        }
    }
    
    foreach (i; 0..cnt) G[i] = G_set[i].keys.array;


    auto dp = new int[][](cnt, 2);
    foreach (i; 0..cnt) dp[i].fill(-1);

    int dfs2(int n, int p, int painted) {
        if (dp[n][painted] >= 0) return dp[n][painted];
        int ret = painted ? size[n] : 0;
        foreach (m; G[n]) {
            if (m == p) continue;
            if (!painted) ret += max(dfs2(m, n, 1), dfs2(m, n, 0));
            else ret += dfs2(m, n, 0);
        }
        dp[n][painted] = ret;
        return ret;
    }

    int ans = 0;
    foreach (i; 0..cnt) if (roots[i]) ans += max(dfs2(i, -1, 0), dfs2(i, -1, 1));
    ans.writeln;
}

class UnionFind {
    int N;
    int[] table;

    this(int n) {
        N = n;
        table = new int[](N);
        fill(table, -1);
    }

    int find(int x) {
        return table[x] < 0 ? x : (table[x] = find(table[x]));
    }

    void unite(int x, int y) {
        x = find(x);
        y = find(y);
        if (x == y) return;
        if (table[x] > table[y]) swap(x, y);
        table[x] += table[y];
        table[y] = x;
    }
}

