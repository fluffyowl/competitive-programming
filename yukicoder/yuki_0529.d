import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

alias Point = Tuple!(int, "x", int, "y", int, "i");

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto Q = s[2];
    auto G = new UndirectedGraph(N);
    foreach (_; 0..M) {
        s = readln.split.map!(to!int);
        G.add_edge(s[0]-1, s[1]-1);
    }
    G.bridge_decomposition;
    int gn = G.group_graph.length.to!int;

    auto T = new HLDecomposition(gn);
    foreach (i; 0..gn) {
        foreach (j; G.group_graph[i]) {
            T.add_edge(i, j);
        }
    }
    T.run(0);

    auto st = new SegmentTree(gn);
    auto W = new BinaryHeap!(Array!int, "a < b")[](gn);

    Tuple!(int, int) calc(int u, int v) {
        int un = T.nodes[u].serial;
        int ug = T.nodes[u].group;
        int vn = T.nodes[v].serial;
        int vg = T.nodes[v].group;
        Tuple!(int, int) ret;
        int g = vg;
        int last = vn;
            
        while (true) {
            if (g == ug && g == vg) {
                ret = max(ret, st.query(un, vn));
                break;
            } else if (g == ug) {
                ret = max(ret, st.query(un, last));
                break;
            } else {
                int g_root = T.groups[g].front;
                ret = max(ret, st.query(T.nodes[g_root].serial, last));
            }
            int p = T.group_parent[g];
            g = T.nodes[p].group;
            last = T.nodes[p].serial;
        }

        return ret;
    }

    while (Q--) {
        s = readln.split.map!(to!int);
        if (s[0] == 1) {
            int u = s[1] - 1;
            int w = s[2];
            u = G.edge_group[u];
            int un = T.nodes[u].serial;
            int ug = T.nodes[u].group;
            W[u].insert(w);
            st.assign(un, tuple(W[u].front, u));
        } else {
            int u = s[1] - 1;
            int v = s[2] - 1;
            u = G.edge_group[u];
            v = G.edge_group[v];
            int w = G.lca_group(u, v);

            auto t = max(calc(w, u), calc(w, v));
            auto maxw = t[0];
            auto maxn = t[1];
            writeln(maxw == 0 ? -1 : maxw);
            
            if (maxw > 0) {
                W[maxn].removeFront;
            } else {
                continue;
            }
            
            if (W[maxn].empty) {
                st.assign(T.nodes[maxn].serial, tuple(0, -1));
            } else {
                st.assign(T.nodes[maxn].serial, tuple(W[maxn].front, maxn));
            }
        }
    }
}

class UndirectedGraph {
    int N;
    int[][] G;
    int[][] dfs_tree;
    int[] dfs_subtree;
    bool[] dfs_subtree_odd;
    int[] ord;
    int[] low;
    int[] edge_group;
    int[][] group_graph;
    int[] depth;
    int[][] dp;
    bool lca_preprocessed = false;

    this (int N) {
        this.N = N;
        G = new int[][](N);
    }

    void add_edge(int u, int v) {
        G[u] ~= v;
        G[v] ~= u;
    }

    int[] articulation_points() {
        dfs_tree = new int[][](N);
        dfs_subtree = new int[](N);
        dfs_subtree_odd = new bool[](N);
        ord = new int[](N);
        low = new int[](N);
        auto used = new bool[](N);
        int cnt = 0;

        int dfs(int n, int p) {
            ord[n] = cnt++;
            low[n] = ord[n];
            used[n] = true;
            foreach (m; G[n]) {
                if (m == p) continue;
                if (used[m]) low[n] = min(low[n], ord[m]);
                else low[n] = min(low[n], dfs(m, n)), dfs_tree[n] ~= m; 
            }
            return low[n];
        }

        int dfs2(int n, int p) {
            dfs_subtree[n] = 1;
            foreach (m; dfs_tree[n]) {
                if (m == p) continue;
                auto s = dfs2(m, n);
                if (s % 2) dfs_subtree_odd[n] = true;
                dfs_subtree[n] += s;
            }
            return dfs_subtree[n];
        }

        int[] ans;

        foreach (i; 0..N) if (!used[i]) dfs(i, -1);
        foreach (i; 0..N) {
            if (ord[i] == 0 && dfs_tree[i].length >= 2) {
                ans ~= i;
            } else if (ord[i] != 0 && dfs_tree[i].map!(j => (low[j] >= ord[i])).any) {
                ans ~= i;
            }
        }

        foreach (i; 0..N) if (ord[i] == 0) dfs2(i, -1);

        return ans;
    }

    void bridge_decomposition() {
        auto uf = new UnionFind(N);
        edge_group = new int[](N);
        edge_group.fill(-1);
        int cnt = 0;
        articulation_points;

        void dfs(int n, int p) {
            foreach (m; dfs_tree[n]) {
                if (m != p && ord[n] >= low[m]) {
                    uf.unite(n, m);
                }
                dfs(m, n);
            }
        } 

        dfs(0, -1);

        /*
        foreach (i; 0..N) {
            foreach (j; G[i]) {
                if (i > j) continue;
                if (ord[i] < low[j]) continue;
                uf.unite(i, j);
            }
        }
        */

        foreach (i; 0..N) {
            if (uf.table[i] < 0) {
                edge_group[i] = cnt++;
            }
        }

        group_graph = new int[][](cnt);

        foreach (i; 0..N) {
            edge_group[i] = edge_group[uf.find(i)];
        }

        foreach (i; 0..N) {
            foreach (j; G[i]) {
                if (i > j) continue;
                if (edge_group[i] == edge_group[j]) continue;
                group_graph[edge_group[i]] ~= edge_group[j];
                group_graph[edge_group[j]] ~= edge_group[i];
            }
        }
    }


    void lca_pre() {
        void dfs(int n, int p, int d) {
            dp[0][n] = p;
            depth[n] = d;
            foreach (m; group_graph[n]) if (m != p) dfs(m, n, d+1);
        }

        int K = group_graph.length.to!int;
        depth = new int[](K);
        dp = new int[][](20, K);
        dfs(0, -1, 0);

        foreach (k; 0..19)
            foreach (n; 0..K)
                dp[k+1][n] = (dp[k][n] == -1) ? -1 : dp[k][dp[k][n]];
    }

    int lca_group(int a, int b) {
        if (!lca_preprocessed) {
            lca_pre;
            lca_preprocessed = true;
        }
        if (depth[a] < depth[b]) swap(a, b);

        auto orig_a = a;
        auto orig_b = b;

        while (depth[a] > depth[b]) {
            int K = 19;
            foreach (k; iota(K, -1, -1)) {
                if (2^^k <= depth[a] - depth[b]) {
                    a = dp[k][a];
                    K = k;
                }
            }
        }

        if (a == b) return a;

        while (dp[0][a] != dp[0][b]) {
            int K = 19;
            foreach (k; iota(K, -1, -1)) {
                if (dp[k][a] != dp[k][b]) {
                    a = dp[k][a];
                    b = dp[k][b];
                    K = k;
                }
            }
        }

        return dp[0][a];
    }
    
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


class HLDecomposition {
    alias Node = Tuple!(int, "group", int, "number", int, "serial");
    
    int N;
    int[][] G;
    int[][] groups;
    int[] parent;
    int[] group_parent;
    Node[] nodes;
    int[] serial_number;

    this (int N) {
        this.N = N;
        G = new int[][](N);
        nodes = new Node[](N);
        parent = new int[](N);
    }

    void add_edge(int u, int v) {
        G[u] ~= v;
    }

    void run(int root) {
        auto subtree_size = dfs_subtree_size(root);
        int group_count = -1;

        void decompose(int n, int p, bool heavy) {
            if (!heavy) {
                group_count += 1;
                groups.length += 1;
                group_parent ~= p;
            }

            parent[n] = p;
            nodes[n] = Node(group_count, groups[group_count].length.to!int, 0);
            groups[group_count] ~= n;

            bool first = true;
            G[n].sort!((a, b) => subtree_size[a] > subtree_size[b]);
            
            foreach (m; G[n]) {
                if (m == p) continue;
                decompose(m, n, first);
                first = false;
            }
        }

        decompose(root, -1, false);
        group_count += 1;
        
        int cnt = 0;
        foreach (g; groups) foreach (n; g) nodes[n].serial = cnt++;
    }

    int[] dfs_subtree_size(int root) {
        auto subtree_size = new int[](N);

        int dfs(int n, int p) {
            subtree_size[n] = 1;
            foreach (m; G[n]) if (m != p) subtree_size[n] += dfs(m, n);
            return subtree_size[n];
        }

        dfs(root, -1);
        return subtree_size;
    }

}


class SegmentTree {
    Tuple!(int, int)[] table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new Tuple!(int, int)[](size);
    }

    void assign(int pos, Tuple!(int, int) num) {
        return assign(pos, num, 0, 0, size/2-1);
    }

    void assign(int pos, Tuple!(int, int) num, int i, int left, int right) {
        if (left == right) {
            table[i] = num;
            return;
        }
        auto mid = (left + right) / 2;
        if (pos <= mid)
            assign(pos, num, i*2+1, left, mid);
        else
            assign(pos, num, i*2+2, mid+1, right);
        table[i] = max(table[i*2+1], table[i*2+2]);
    }

    Tuple!(int, int) query(int pl, int pr) {
        return query(pl, pr, 0, 0, size/2-1);
    }

    Tuple!(int, int) query(int pl, int pr, int i, int left, int right) {
        if (pl > right || pr < left)
            return tuple(0, -1);
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return
                max(query(pl, pr, i*2+1, left, (left+right)/2),
                    query(pl, pr, i*2+2, (left+right)/2+1, right));
    }
}

