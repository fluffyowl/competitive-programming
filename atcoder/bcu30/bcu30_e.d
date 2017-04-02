import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

alias Tuple!(int, "r", int, "c") Point;
int N, K, Q;
char[][] B;
int[][] rolling;
bool[1010][1010] used;
int[4] dr = [1, -1, 0, 0];
int[4] dc = [0, 0, 1, -1];
UnionFind uf;


class UnionFind {
    int N;
    int[] table;

    this(int n) {
        N = n;
        table = new int[](N);
        fill(table, -1);
    }

    int hash(Point p) {
        return p.r * 1000 + p.c;
    }
    
    int find(int x) {
        return table[x] < 0 ? x : (table[x] = find(table[x]));
    }

    int find(Point p) {
        return find(hash(p));
    }

    void unite(int x, int y) {
        x = find(x);
        y = find(y);
        if (x == y) return;
        if (table[x] < table[y]) swap(x, y);
        table[x] += table[y];
        table[y] = x;
    }

    void unite(Point p1, Point p2) {
        unite(hash(p1), hash(p2));
    }
}


void dfs(int or, int oc, int r, int c) {
    if (used[r][c]) return;
    used[r][c] = true;
    uf.unite(Point(or, oc), Point(r, c));

    foreach (i; 0..4) {
        int nr = r + dr[i];
        int nc = c + dc[i];
        if (nr < 0 || nr+K-1 >= N || nc < 0 || nc+K-1 >= N) continue;
        if (rolling[nr][nc] > 0) continue;
        dfs(or, oc, nr, nc);
    }
}

void main() {
    auto s = readln.split.map!(to!int);
    N = s[0];
    K = s[1];
    Q = s[2];
    B = N.iota.map!(_ => readln.chomp.to!(char[])).array;
    rolling = new int[][](N, N);

    foreach (i; 0..N) {
        rolling[i][0] = B[i][0..K].count('#').to!int;
        foreach (j; 1..N-K+1) {
            rolling[i][j] = rolling[i][j-1] + (B[i][j+K-1] == '#');
            rolling[i][j] -= (B[i][j-1] == '#');
        } 
    }

    foreach (j; 0..N-K+1) {
        foreach (i; 0..N-K+1) {
            foreach (k; 0..K)
                rolling[i][j] += rolling[i+k][j];
        }
    }

    
    uf = new UnionFind(1010*1010);
    foreach (i; 0..N)
        foreach (j; 0..N)
            if (!used[i][j])
                dfs(i, j, i, j);

    foreach (q; 0..Q) {
        s = readln.split.map!(to!int);
        bool ok = uf.find(Point(s[0]-1, s[1]-1)) == uf.find(Point(s[2]-1, s[3]-1));
        writeln(ok ? "Yes" : "No");
    }
}
