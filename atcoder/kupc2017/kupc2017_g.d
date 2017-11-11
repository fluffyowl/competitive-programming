import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void encode() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto edges = new int[][](N);
    foreach (i; 0..N-1) {
        s = readln.split.map!(to!int);
        edges[s[0] - 1] ~= s[1] - 1;
        edges[s[1] - 1] ~= s[0] - 1;
    }
    auto X = readln.chomp.to!long;

    auto A = N.iota.array;
    A.sort!((a, b) => edges[a].length < edges[b].length);
    Tuple!(int, int)[] new_edges;

    string B = format("%060b", X);
    int zero = B.map!(b => b == '0').sum;
    int one = 60 - zero;
    auto used = new bool[](N);
    int cnt = zero >= one ? 4 : 5;

    for (int i = N - 1; i > 0 && cnt > 0; --i) {
        if (edges[A[0]].canFind(A[i])) continue;
        new_edges ~= tuple(A[0], A[i]);
        used[A[i]] = true;
        cnt--;
    }


    int[] prev = [0];
    int[] next;
    foreach (mask; 0..61) {
        int b = (X & (1L << mask)) > 0;
        if ((zero >= one && b == 0) || (zero < one && b == 1)) {
            cnt = 1;
        } else {
            cnt = 2;
        }

        for (int i = 1; i < N && cnt > 0; ++i) {
            if (used[A[i]]) continue;
            bool ok = true;
            foreach (p; prev) if (edges[A[p]].canFind(A[i])) ok = false;
            if (!ok) continue;

            foreach (p; prev) new_edges ~= tuple(A[p], A[i]);
            next ~= i;
            cnt -= 1;
            used[A[i]] = true;
        }

        prev = next.dup;
        next = [];
    }

    new_edges.length.writeln;
    foreach (e; new_edges) writeln(e[0] + 1, " ", e[1] + 1);

}

void decode() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto A = s[1];
    auto edges = new int[][](N);
    foreach (i; 0..A) {
        s = readln.split.map!(to!int);
        edges[s[0] - 1] ~= s[1] - 1;
        edges[s[1] - 1] ~= s[0] - 1;
    }

    int n = -1;
    foreach (i; 0..N) if (edges[i].length >= 5) n = i;

    auto used = new bool[](N);
    foreach (m; edges[n]) if (edges[m].length == 1) used[m] = true;
    used[n] = true;

    int[] mp;
    if (used.sum == 5) mp = [0, 0, 1];
    else mp = [0, 1, 0];

    int prev = n;
    int next;
    long Y = 0;
    foreach (mask; 0..61) {
        int cnt = 0;
        foreach (m; edges[prev]) {
            if (!used[m]) {
                cnt += 1;
                used[m] = true;
                next = m;
            }
        }
        Y |= (mp[cnt].to!long << mask);
        prev = next;
        next = -1;
    }

    Y.writeln;
}

void main() {
    auto S = readln.chomp;
    if (S.canFind("encode"))
        encode;
    else
        decode;
}
