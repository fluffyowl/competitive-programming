import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.datetime;

struct Mat {
    long a, b, c, d;
}

immutable long MOD = 10^^9 + 7;
immutable Mat E = Mat(1L, 0L, 0L, 1L);

Mat mul(Mat X, Mat Y) {
    auto a = X.a * Y.a + X.b * Y.c;
    auto b = X.a * Y.b + X.b * Y.d;
    auto c = X.c * Y.a + X.d * Y.c;
    auto d = X.c * Y.b + X.d * Y.d;
    return Mat(a % MOD, b % MOD,
               c % MOD, d % MOD);
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
    Mat[] table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new Mat[](size);
        table.fill(E);
    }

    void assign(int pos, Mat X) {
        return assign(pos, X, 0, 0, size/2-1);
    }

    void assign(int pos, Mat X, int i, int left, int right) {
        if (left == right) {
            table[i] = X;
            return;
        }
        
        auto mid = (left + right) / 2;
        if (pos <= mid)
            assign(pos, X, i*2+1, left, mid);
        else
            assign(pos, X, i*2+2, mid+1, right);

        table[i] = mul(table[i*2+1], table[i*2+2]);
    }

    Mat sum(int pl, int pr) {
        return sum(pl, pr, 0, 0, size/2-1);
    }

    Mat sum(int pl, int pr, int i, int left, int right) {
        if (pl > right || pr < left)
            return E;
        else if (pl <= left && right <= pr)
            return table[i];
        return
            mul(sum(pl, pr, i*2+1, left, (left+right)/2),
                sum(pl, pr, i*2+2, (left+right)/2+1, right));
    }
}


void main() {
    auto N = readln.chomp.to!int;
    auto G = new HLDecomposition(N);
    auto edges = new Tuple!(int, int)[](N-1);
    foreach (i; 0..N-1) {
        auto s = readln.split.map!(to!int);
        G.add_edge(s[0], s[1]);
        G.add_edge(s[1], s[0]);
        edges[i] = tuple(s[0], s[1]);
    }
    
    G.run(0);

    foreach (i; 0..N-1) {
        if (G.parent[edges[i][0]] == edges[i][1]) {
            swap(edges[i][0], edges[i][1]);
        }
    }

    auto st = new SegmentTree(N);

    auto Q = readln.chomp.to!int;
    while (Q--) {
        auto q = readln.split;
        if (q[0] == "x") {
            int v = edges[q[1].to!int][1];
            int n = G.nodes[v].serial;
            st.assign(n, Mat(q[2].to!long, q[3].to!long, q[4].to!long, q[5].to!long));
        } else {
            int u = q[1].to!int;
            int v = q[2].to!int;
            int un = G.nodes[u].serial;
            int ug = G.nodes[u].group;
            int vn = G.nodes[v].serial;
            int vg = G.nodes[v].group;
            Mat[] ret;
            int g = vg;
            int last = vn;
            
            while (true) {
                if (g == ug && g == vg) {
                    ret ~= st.sum(un+1, vn);
                    break;
                } else if (g == ug) {
                    if (G.groups[g].back != u) {
                        ret ~= st.sum(un+1, last);
                    }
                    break;
                } else {
                    int g_root = G.groups[g].front;
                    ret ~= st.sum(G.nodes[g_root].serial, last);
                }
                int p = G.group_parent[g];
                g = G.nodes[p].group;
                last = G.nodes[p].serial;
            }
            ret.reverse();
            auto ans = Mat(1L, 0L, 0L, 1L);
            foreach (r; ret) ans = mul(ans, r);
            writeln(ans.a, " ", ans.b, " ", ans.c, " ", ans.d);
        }
    }
}

