import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable int INF = 10^^9 + 2;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;

    int ans = -1;

    foreach (k; 0..1000) {
        auto B = new int[](N + k);
        fill(B, -INF);
        foreach (i; 0..N) B[i + k] = A[i];
        if (B.length % 2 == 0) B ~= 10^^9 + 1;
        auto M = B.length.to!int;

        bool[int] used;
        foreach (a; A) used[a] = true;

        foreach (i; iota(M-1, 0, -2)) {
            if (B[i] == -INF) {
                int x = 10^^9;
                while (x in used) x--;
                B[i] = x;
                used[x] = true;
            }
            if (B[i-1] == -INF) {
                int x = 10^^9;
                while (x in used) x--;
                B[i-1] = x;
                used[x] = true;
            }
            int x = min(B[i], B[i-1]) - 1;
            if (B[i/2-1] != -INF) continue;
            while (x in used) x--;
            used[x] = true;
            B[i/2-1] = x;
        }

        bool ok = true;
        foreach (i; 0..M) {
            if (B[i] < 0) ok = false;
            if (i * 2 + 1 < M && B[i] >= B[i * 2 + 1]) ok = false;
            if (i * 2 + 2 < M && B[i] >= B[i * 2 + 2]) ok = false;
        }

        if (ok) {
            ans = N + k;
            break;
        }
    }

    ans.writeln;
}
