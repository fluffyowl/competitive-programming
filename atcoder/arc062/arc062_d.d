import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto K = s[2];
    auto G = new UndirectedGraph(N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G.add_edge(s[0]-1, s[1]-1);
    }

    auto bicom = biconnected_decomposition(G);
    long ans = 1;
    //foreach (b; bicom) {
    //    b.map!(a => "(" ~ to!string(a[0]+1) ~ ", " ~ to!string(a[1]+1) ~ ")").join(" ").writeln;
    //}


    foreach (edges; bicom) {
        int[] nodes;
        foreach (e; edges) nodes ~= e[0], nodes ~= e[1];
        nodes = nodes.sort().uniq().array;

        if (edges.length == 1) {
            ans = ans * K % MOD;
        } else if (edges.length == nodes.length) {
            long tmp = 0;
            foreach (i; 0..nodes.length) {
                tmp += powmod(K, gcd(nodes.length.to!long, i.to!long), MOD);
                tmp %= MOD;
            }
            tmp = tmp * powmod(nodes.length.to!long, MOD-2, MOD) % MOD;
            ans = ans * tmp % MOD;
        } else {
            ans = ans * comb(K + edges.length.to!int - 1, edges.length.to!int) % MOD;
        }
    }

    ans.writeln;
}

Tuple!(int, int)[][] biconnected_decomposition(UndirectedGraph g) {
    Tuple!(int, int)[][] ret;

    int cnt = 0;
    Tuple!(int, int)[] stack;
    auto ord = new int[](g.N);
    auto low = new int[](g.N);
    fill(ord, -1);
    fill(low, -1);

    void dfs(int n, int p)  {
        ord[n] = cnt;
        low[n] = cnt;
        cnt += 1;
        foreach (m; g.adj[n]) {
            if (ord[m] == -1) {
                stack ~= tuple(n, m);
                dfs(m, n);
                low[n] = min(low[n], low[m]);
                if (low[m] >= ord[n]) {
                    Tuple!(int, int)[] bicom;
                    while (bicom.empty || bicom.back != tuple(n, m)) {
                        bicom ~= stack.back;
                        stack.popBack;
                    }
                    ret ~= bicom.dup;
                }
            } else if (ord[m] < ord[n] && m != p) {
                stack ~= tuple(n, m);
                low[n] = min(low[n], ord[m]);
            }
        }
    }

    foreach (i; 0..g.N) {
        if (ord[i] == -1) dfs(i, -1);
    }

    return ret;
}

class UndirectedGraph {
    int N;
    int[][] adj;

    this (int N) {
        this.N = N;
        adj = new int[][](N);
    }

    void add_edge(int u, int v) {
        adj[u] ~= v;
        adj[v] ~= u;
    }
}

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

long comb(long n, long k) {
    long ret = 1;
    foreach (i; 1..n+1) ret = ret * i % MOD;
    foreach (i; 1..n-k+1) ret = ret * powmod(i, MOD-2, MOD) % MOD;
    foreach (i; 1..k+1) ret = ret * powmod(i, MOD-2, MOD) % MOD;
    return ret;
}
