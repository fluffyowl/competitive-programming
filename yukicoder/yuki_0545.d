import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable long INF = 1L << 60;

void main() {
    auto N = readln.chomp.to!int;
    auto AB = new long[][](N, 2);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!long);
        AB[i][0] = s[0];
        AB[i][1] = s[1];
    }

    if (N == 0) {
        writeln(0);
        return;
    }
    if (N == 1) {
        writeln(min(abs(AB[0][0]), abs(AB[0][1])));
        return ;
    }

    auto A = N / 2 + N % 2;
    auto B = N / 2;
    auto dp1 = new long[](1 << A);
    auto dp2 = new long[](1 << B);

    foreach (mask; 0..(1 << A)) {
        foreach (i; 0..A) {
            if (mask & (1 << i)) dp1[mask] += AB[i][0];
            else dp1[mask] -= AB[i][1];
        }
    }

    foreach (mask; 0..(1 << B)) {
        foreach (i; 0..B) {
            if (mask & (1 << i)) dp2[mask] += AB[i+A][0];
            else dp2[mask] -= AB[i+A][1];
        }
    }

    dp1.sort();
    dp2.sort();
    long ans = INF;

    foreach (i; 0..(1 << A)) {
        int j = dp2.assumeSorted.lowerBound(-dp1[i] + 1).length.to!int;
        if (j < dp2.length) ans = min(ans, abs(dp1[i] + dp2[j]));
        if (j > 0 && j - 1 < dp2.length) ans = min(ans, abs(dp1[i] + dp2[j-1]));
    }

    ans.writeln;
}

