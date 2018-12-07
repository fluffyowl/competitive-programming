import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto L = s[2];
    auto T = readln.split.map!(to!long).array;
    auto X = new Tuple!(int, long)[](M);
    auto Y = new long[][](N);
    foreach (i; 0..M) {
        s = readln.split.map!(to!int);
        X[i] = tuple(s[0]-1, s[1].to!long);
    }
    foreach (i; 0..L) {
        s = readln.split.map!(to!int);
        Y[s[0]-1] ~= s[1].to!long;
    }
    X.sort!"a[1] < b[1]";
    foreach (i; 0..N) Y[i].sort();

    auto pq = new BinaryHeap!(Array!(Tuple!(long, long)), "a[0] > b[0]")();
    long cur = 0;
    long ans = 0;

    foreach (i; 0..M) {
        int a = X[i][0];
        while (!pq.empty && pq.front[0] < X[i][1]) {
            cur = max(cur, pq.front[1]);
            pq.removeFront;
        }
        long d = X[i][1] + T[a] + 1;

        auto lb = Y[a].assumeSorted.lowerBound(d).length.to!int;
        if (lb == Y[a].length) {
            ans = max(ans, cur + 1);
        } else {
            long nd = Y[a][lb] + T[a];
            pq.insert(tuple(nd, cur + 2));
            ans = max(ans, cur + 2);
        }
    }

    ans.writeln;
}
