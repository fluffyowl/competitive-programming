import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = N.iota.map!(_ => readln.split.map!(to!int).array).array;

    auto C = new int[](M+1);
    foreach (i; 0..N) C[A[i][0]] += 1;

    auto ans = C.reduce!max;

    auto p = new int[](N);
    auto used = new bool[](M+1);
    auto pq = BinaryHeap!(Array!(Tuple!(int, int)), "a[1] < b[1]")();
    foreach (i; 1..M+1) pq.insert(tuple(i, C[i]));

    for (int cnt = 0; cnt < M - 1; ) {
        auto x = pq.front;
        auto n = x[0];
        auto c = x[1];
        pq.removeFront;
        if (used[n]) continue;
        cnt++;
        used[n] = true;

        fill(C, 0);
        foreach (j; 0..N) while (p[j] < M && used[ A[j][p[j]] ]) p[j]++;
        foreach (j; 0..N) C[A[j][p[j]]] += 1;
        foreach (j; 1..M+1) if (C[j] != 0) pq.insert(tuple(j, C[j]));
        ans = min(ans, C.reduce!max);
    }

    ans.writeln;
}
