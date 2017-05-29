import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int).array;
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto Q = readln.chomp.to!int;
    auto RCX = Q.iota.map!(_ => readln.split.map!(to!int).array).array;

    auto uf = new UnionFind(H*W);
    foreach (i; 0..H) foreach (j; 0..W) uf.color[i*W+j] = A[i][j];

    auto used = new bool[][](H, W);
    int[4] dr = [0, 0, -1, 1];
    int[4] dc = [-1, 1, 0, 0];

    void dfs(int r, int c, int p) {
        if (used[r][c]) return;
        used[r][c] = true;
        uf.unite(p, r*W+c, A[r][c]);
        foreach (i; 0..4) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            if (nr < 0 || nr >= H || nc < 0 || nc >= W) continue;
            if (used[nr][nc]) continue;
            if (A[nr][nc] != A[r][c]) continue;
            dfs(nr, nc, p);
        }
    }

    foreach (i; 0..H)
        foreach (j; 0..W)
            if (!used[i][j])
                dfs(i, j, i*W+j);


    bool cancel = false;
    
    foreach (q; 0..Q) {
        RCX[q][0]--, RCX[q][1]--;
        auto n = uf.find(RCX[q][0] * W + RCX[q][1]);
        auto x = RCX[q][2];
        if (uf.color[n] == x) continue;
        if (uf.table[n] == -H*W) {
            cancel = true;
            break;
        }

        int[] to_unite;
        foreach (m; uf.members[n]) {
            int i = m / W;
            int j = m % W;
            foreach (k; 0..4) {
                int ni = i + dr[k];
                int nj = j + dc[k];
                if (ni < 0 || ni >= H || nj < 0 || nj >= W) continue;
                if (uf.find(m) == uf.find(ni*W+nj)) continue;
                to_unite ~= (ni * W + nj);
            }
        }

        foreach (tu; to_unite) uf.unite(n, tu, x);
    }

    if (cancel) uf.color[uf.find(0)] = RCX[$-1][2];


    auto ans = new int[][](H, W);

    foreach (n; 0..H*W) {
        if (uf.table[n] >= 0) continue;
        foreach (m; uf.members[n]) {
            int r = m / W;
            int c = m % W;
            ans[r][c] = uf.color[n];
        }
    }

    ans.each!(an => an.map!(a => a.to!string).join(" ").writeln);
}

class UnionFind {
    int N;
    int[] table;
    int[] color;
    int[][] members;

    this(int n) {
        N = n;
        table = new int[](N);
        color = new int[](N);
        members = new int[][](N);
        
        fill(table, -1);
        foreach (i; 0..n) members[i] = [i];
    }

    int find(int x) {
        return table[x] < 0 ? x : (table[x] = find(table[x]));
    }

    void unite(int x, int y, int c) {
        x = find(x);
        y = find(y);
        if (x == y) return;
        if (table[x] > table[y]) swap(x, y);
        table[x] += table[y];
        table[y] = x;
        foreach (m; members[y]) members[x] ~= m;
        color[x] = c;
        members[y] = [];
    }
}

