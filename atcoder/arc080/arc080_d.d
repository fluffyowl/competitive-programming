import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    
    int[] B;
    foreach (a; A) {
        foreach (b; a-1..a+1) {
            if (B.length > 0 && B[$-1] == b) B.popBack;
            else B ~= b;
        }
    }

    auto P = new bool[](10^^7 + 10);
    fill(P, true);
    P[0] = P[1] = false;
    for (int i = 2; i < 10^^7 + 10; i++) {
        if (!P[i]) continue;
        for (int j = i + i; j < 10^^7 + 10; j += i) P[j] = false;
    }


    B.sort!"a % 2 > b % 2"();
    int M = B.length.to!int;
    int source = M;
    int sink = M + 1;
    int odd = B.map!(b => b % 2).sum;
    int even = B.map!(b => 1 - b % 2).sum;
    auto FF = new FordFulkerson(M + 2, source, sink);
    foreach (i; 0..odd) FF.add_edge(source, i, 1);
    foreach (i; odd..odd+even) FF.add_edge(i, sink, 1);
    foreach (i; 0..odd) {
        foreach (j; odd..odd+even) {
            if (P[abs(B[i] - B[j])]) FF.add_edge(i, j, 1);
        }
    }
    
    int one = FF.run;
    odd -= one;
    even -= one;
    int two = odd / 2 + even / 2;
    int three = odd % 2;

    writeln(one + two * 2 + three * 3);
}



class FordFulkerson {
    int N, source, sink;
    int[][] adj;
    int[][] flow;
    bool[] used;

    this(int n, int s, int t) {
        N = n;
        source = s;
        sink = t;
        assert (s >= 0 && s < N && t >= 0 && t < N);
        adj = new int[][](N);
        flow = new int[][](N, N);
        used = new bool[](N);
    }

    void add_edge(int from, int to, int cap) {
        adj[from] ~= to;
        adj[to] ~= from;
        flow[from][to] = cap;
    }

    int dfs(int v, int min_cap) {
        if (v == sink)
            return min_cap;
        if (used[v])
            return 0;
        used[v] = true;
        foreach (to; adj[v]) {
            if (!used[to] && flow[v][to] > 0) {
                auto bottleneck = dfs(to, min(min_cap, flow[v][to]));
                if (bottleneck == 0) continue;
                flow[v][to] -= bottleneck;
                flow[to][v] += bottleneck;
                return bottleneck;
            }
        }
        return 0;
    }

    int run() {
        int ret = 0;
        while (true) {
            foreach (i; 0..N) used[i] = false;
            int f = dfs(source, int.max);
            if (f > 0)
                ret += f;
            else
                return ret;
        }
    }
}
