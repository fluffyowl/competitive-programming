import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto P = new Tuple!(long, long)[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!long);
        P[i] = tuple(s[0], s[1]);
    }
    auto M = readln.chomp.to!int;
    auto T = M.iota.map!(i => tuple(readln.chomp.to!long, i)).array;
    auto ans = new long[](M);

    P.sort!"a[0] < b[0]";
    T.sort!"a[0] < b[0]";

    long calc(int p, long t) {
        return P[p][1] + max(0, t - P[p][0]);
    }

    for (int i = 0, j = 0; i < M; ++i) {
        while (j + 1 < N && P[j+1][0] < T[i][0]) ++j;
        long tmp = 1L << 59;
        if (j > 0) tmp = min(tmp, calc(j-1, T[i][0]));
        tmp = min(tmp, calc(j, T[i][0]));
        if (j < N - 1) tmp = min(tmp, calc(j+1, T[i][0]));
        ans[T[i][1]] = tmp;
    }

    ans.each!writeln;
}
