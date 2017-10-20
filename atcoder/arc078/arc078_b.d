import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto edges = new int[][](N);

    foreach (i; 0..N-1) {
        auto s = readln.split.map!(to!int);
        edges[s[0] - 1] ~= s[1] - 1;
        edges[s[1] - 1] ~= s[0] - 1;
    }

    int[] path;

    bool dfs(int n, int p) {
        if (n == N - 1) {
            path ~= N - 1;
            return true;
        }
        foreach (m; edges[n]) if (m != p && dfs(m, n)) {
            path ~= n;
            return true;
        }
        return false;
    }

    dfs(0, -1);
    path.reverse();
    auto colors = new int[](N);

    DList!(int) A;
    DList!(int) B;
    int M = path.length.to!int;

    foreach (i; 0..M/2+M%2) colors[path[i]] = 1, A.insertBack(path[i]);
    foreach (i; M/2+M%2..M) colors[path[i]] = 2, B.insertBack(path[i]);


    void bfs(DList!int q, int c) {
        while (!q.empty) {
            int n = q.front;
            q.removeFront;
            colors[n] = c;
            foreach (m; edges[n]) if (colors[m] == 0) q.insertBack(m);
        }
    }

    bfs(A, 1);
    bfs(B, 2);

    int a = 0, b = 0;
    foreach (c; colors) if (c == 1) a += 1; else b += 1;

    writeln( a > b ? "Fennec" : "Snuke" );
}
