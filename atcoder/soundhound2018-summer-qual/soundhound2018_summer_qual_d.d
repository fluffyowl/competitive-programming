import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto S = s[2] - 1;
    auto T = s[3] - 1;

    auto G = new Tuple!(int, long)[][](N);
    auto H = new Tuple!(int, long)[][](N);
    foreach (i; 0..M) {
        auto t = readln.split;
        G[t[0].to!int-1] ~= tuple(t[1].to!int-1, t[2].to!long);
        G[t[1].to!int-1] ~= tuple(t[0].to!int-1, t[2].to!long);
        H[t[0].to!int-1] ~= tuple(t[1].to!int-1, t[3].to!long);
        H[t[1].to!int-1] ~= tuple(t[0].to!int-1, t[3].to!long);
    }

    auto A = new long[](N);
    auto B = new long[](N);
    fill(A, INF);
    fill(B, INF);

    void dij(long[] D, Tuple!(int, long)[][] F, int start) {
        auto pq = new BinaryHeap!(Array!(Tuple!(int, long)), "a[1] > b[1]")();
        pq.insert(tuple(start, 0L));
        while (!pq.empty) {
            auto t = pq.front;
            pq.removeFront;
            auto n = t[0];
            auto d = t[1];
            if (d >= D[n]) continue;
            D[n] = d;
            foreach (to; F[n]) {
                auto m = to[0];
                auto nd = d + to[1];
                if (nd >= D[m]) continue;
                pq.insert(tuple(m, nd));
            }
        }
    }

    dij(A, G, S);
    dij(B, H, T);

    auto hoge = new long[](N);
    foreach (i; 0..N) hoge[i] = A[i] + B[i];
    foreach_reverse (i; 0..N-1) hoge[i] = min(hoge[i], hoge[i+1]);
    foreach (i; 0..N) writeln(10L^^15 - hoge[i]);
}
