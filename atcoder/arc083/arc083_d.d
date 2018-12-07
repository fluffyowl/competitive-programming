import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

alias Point = Tuple!(int, "x", int, "y");
alias Edge = Tuple!(int, "to", int, "x", int, "y");

immutable long MOD = 10^^9 + 7;

void main() {
    auto N = readln.chomp.to!int;
    auto G = new Edge[][](2*N); // ロボットが頂点、ボールが辺
    auto uf = new UnionFind(2*N);
    auto balls = new Point[](2*N);
    auto deg = new int[](2*N);
    auto used = new bool[](2*N);
    auto stack = new int[](2*N);
    foreach (i; 0..2*N) {
        auto s = readln.split.map!(to!int);
        int x = s[0] - 1;
        int y = s[1] - 1;
        balls[i] = Point(x, y);
        G[x] ~= Edge(y + N, x, y);
        G[y + N] ~= Edge(x, x, y);
        deg[x] += 1;
        deg[y + N] += 1;
        uf.unite(x, y + N);
    }

    long[] F = new long[](2*N+1);
    F[0] = 1;
    foreach (i; 0..2*N) F[i+1] = F[i] * (i + 1) % MOD;

    foreach (i; 0..2*N) { // 各連結成分において 辺数 = 頂点数 が成り立ってないと駄目
        if (uf.find(i) != i) {
            continue;
        }
        if (uf.edges[i] != uf.group[i].length) {
            writeln(0);
            return;
        }
    }


    long topological_count(const long[] len, const long[] num) {
        long ret = F[len.sum];
        foreach (i; 0..len.length) {
            ret = ret * powmod(F[len[i]], MOD-2, MOD) % MOD;
            ret = ret * num[i] % MOD;
        }
        return ret;
    }

    long calc(Tuple!(int, Edge)[] matching) {
        int n = matching.length.to!int;

        Tuple!(int, int)[int] X;
        Tuple!(int, int)[int] Y;

        auto tree = new int[][](n);
        auto is_root = new bool[](n);
        fill(is_root, true);

        foreach (i; 0..n) {
            if (matching[i][0] < N) {
                X[matching[i][1].x] = tuple(matching[i][1].y, i);
            } else {
                Y[matching[i][1].y] = tuple(matching[i][1].x, i);
            }
        }

        // ひとつのマッチングをひとつの頂点とみなして、マッチングの順序関係からDAGをつくる(必ず有向森になる)

        foreach (i; 0..n) {
            if (matching[i][0] < N) {
                if (matching[i][1].y in Y && matching[i][1].x < Y[matching[i][1].y][0]) {
                    tree[Y[matching[i][1].y][1]] ~= i;
                    is_root[i] = false;
                }
            } else {
                if (matching[i][1].x in X && matching[i][1].y < X[matching[i][1].x][0]) {
                    tree[X[matching[i][1].x][1]] ~= i;
                    is_root[i] = false;
                }
            }
        }

        // つくった森をトポロジカルソートするやり方が何通りあるか数える

        Tuple!(long, long) dfs(int n, int p) {
            long[] len, num;
            foreach (m; tree[n]) {
                if (m == p) continue;
                auto t = dfs(m, n);
                len ~= t[0];
                num ~= t[1];
            }
            return tuple(len.sum+1, topological_count(len, num));
        }

        long[] len, num;
        foreach (i; 0..n) {
            if (!is_root[i]) continue;
            auto t = dfs(i, -1);
            len ~= t[0];
            num ~= t[1];
        }

        return topological_count(len, num);
    }

    long solve(const int[] nodes) {
        int[] cycle_nodes;
        Edge[] cycle_edges;
        Tuple!(int, Edge)[] not_cycle;

        int sp = -1;
        foreach (n; nodes) if (deg[n] == 1) stack[++sp] = n;

        while (sp >= 0) {
            int n = stack[sp--];
            used[n] = true;
            foreach (e; G[n]) {
                if (used[e.to]) continue;
                deg[e.to] -= 1;
                if (deg[e.to] == 1) stack[++sp] = e.to;
                not_cycle ~= tuple(n, e);
                break;
            }
        }

        foreach (start; nodes) {
            if (used[start]) continue;
            int next = start;
            while (cycle_nodes.empty || next != start) {
                cycle_nodes ~= next;
                int cur = next;
                used[cur] = true;
                foreach (e; G[cur]) {
                    if (e.to == start && cycle_nodes.length == 2) continue;
                    if (e.to != start && used[e.to]) continue;
                    cycle_edges ~= e;
                    next = e.to;
                    break;
                }
            }
            break;
        }


        Tuple!(int, Edge)[] cycle1; // サイクル順周り
        Tuple!(int, Edge)[] cycle2; // サイクル逆周り
        int cnt = cycle_nodes.length.to!int;

        foreach (i; 0..cnt) {
            cycle1 ~= tuple(cycle_nodes[i], cycle_edges[i]);
        }
        foreach (i; 0..cnt) {
            cycle2 ~= tuple(cycle_nodes[(i+1)%cnt], Edge(cycle_nodes[i], cycle_edges[i].x, cycle_edges[i].y));
        }

        return (calc(cycle1 ~ not_cycle) + calc(cycle2 ~ not_cycle)) % MOD;
    }


    long[] len, num;

    foreach (i; 0..2*N) {
        if (uf.find(i) != i) {
            continue;
        }
        len ~= uf.group[i].length.to!long;
        num ~= solve(uf.group[i]);
    }

    long ans = topological_count(len, num);
    ans.writeln;
}


class UnionFind {
    int N;
    int[] table;
    int[][] group;
    int[] edges;

    this(int n) {
        N = n;
        table = new int[](N);
        fill(table, -1);
        group = N.iota.map!(i => [i]).array;
        edges = new int[](N);
    }

    int find(int x) {
        return table[x] < 0 ? x : (table[x] = find(table[x]));
    }

    void unite(int x, int y) {
        x = find(x);
        y = find(y);
        if (x == y) {
            edges[x] += 1;
            return;
        }
        if (table[x] > table[y]) swap(x, y);
        table[x] += table[y];
        table[y] = x;
        group[x] ~= group[y].dup;
        group[y] = [];
        edges[x] += edges[y] + 1;
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
