import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    alias Tuple!(int, "to", long, "cost") Edge;

    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto C = N.iota.map!(_ => readln.chomp.to!long).array;
    auto edges = new Edge[][](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        edges[s[0] - 1] ~= Edge(s[1] - 1, s[2]);
        edges[s[1] - 1] ~= Edge(s[0] - 1, s[2]);
    }


    long ans = 0;
    auto used = new bool[](N);
    auto queue = new BinaryHeap!(Array!Edge, "a.cost>=b.cost")();

    foreach (i; 0..N)
        queue.insert(Edge(i, C[i]));

    while (!queue.empty) {
        auto e = queue.front;
        queue.removeFront;

        if (used[e.to])
            continue;

        used[e.to] = true;
        ans += e.cost;

        foreach (f; edges[e.to]) {
            if (used[f.to])
                continue;
            queue.insert(f);
        }
    }

    ans.writeln;

}
