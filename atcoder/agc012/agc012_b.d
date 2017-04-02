import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

alias Tuple!(int, "n", int, "d") Node;
alias Tuple!(int, "v", int, "d", int, "c") Query;
int N, M, Q;
int[] C;
int[][] adj;

void main() {
    auto s = readln.split.map!(to!int);
    N = s[0];
    M = s[1];
    adj = new int[][](N);
    C = new int[](N);

    foreach (i; 0..M) {
         s = readln.split.map!(to!int);
         adj[s[0]-1] ~= s[1]-1;
         adj[s[1]-1] ~= s[0]-1;
    }

    Q = readln.chomp.to!int;
    auto queries = new Query[](Q);
    foreach (i; 0..Q) {
        s = readln.split.map!(to!int);
        queries[i] = Query(s[0]-1, s[1], s[2]);
    }

    auto used = new int[](N);
    fill(used, -1);

    foreach (i; iota(Q-1, -1, -1)) {
        int start = queries[i][0];
        int dist  = queries[i][1];
        int color = queries[i][2];
        DList!Node queue;
        queue.insert(Node(start, dist));
        while (!queue.empty) {
            auto node = queue.front;
            auto n = node.n;
            auto d = node.d;
            queue.removeFront;
            if (used[n] < 0)
                C[n] = color;
            if (used[n] >= d) continue;
            used[n] = d;
            if (d == 0) continue;
            foreach (m; adj[n]) {
                queue.insert(Node(m, d-1));
            }
        }
    }

    C.each!writeln;
}
