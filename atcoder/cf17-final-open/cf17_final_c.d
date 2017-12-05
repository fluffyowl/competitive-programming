import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto C = new int[](13);

    foreach (a; A)
        C[a] += 1;

    if (N >= 24 || C[0] > 0 || C[12] > 1 || C.map!(c => c >= 3).any) {
        writeln(0);
        return;
    }

    foreach (i; 0..12) {
        if (C[i] >= 2 && C[i+1] >= 2) {
            writeln(1);
            return;
        }
    }

    int ans = 0;

    foreach (i; 0..(1 << N)) {
        auto jikan = new int[](24);
        jikan[0] = 1;

        foreach (j; 0..N) {
            if (i & (1 << j)) {
                jikan[A[j]] += 1;
            } else {
                jikan[24-A[j]] += 1;
            }
        }

        int tmp = 1 << 29;

        foreach (j; 0..24) {
            foreach (k; 0..24) {
                if (j != k && jikan[j] && jikan[k]) {
                    int jisa = abs(j-k);
                    tmp = min(tmp, min(jisa, 24-jisa));
                } else if (j == k && jikan[j] >= 2) {
                    tmp = 0;
                }
            }
        }
        ans = max(ans, tmp);
    }

    ans.writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto C = new int[](13);

    foreach (a; A)
        C[a] += 1;

    if (N >= 24 || C[0] > 0 || C[12] > 1 || C.map!(c => c >= 3).any) {
        writeln(0);
        return;
    }

    foreach (i; 0..12) {
        if (C[i] >= 2 && C[i+1] >= 2) {
            writeln(1);
            return;
        }
    }

    int ans = 0;

    foreach (i; 0..(1 << N)) {
        auto jikan = new int[](24);
        jikan[0] = 1;

        foreach (j; 0..N) {
            if (i & (1 << j)) {
                jikan[A[j]] += 1;
            } else {
                jikan[24-A[j]] += 1;
            }
        }

        int tmp = 1 << 29;

        foreach (j; 0..24) {
            foreach (k; 0..24) {
                if (j != k && jikan[j] && jikan[k]) {
                    int jisa = abs(j-k);
                    tmp = min(tmp, min(jisa, 24-jisa));
                } else if (j == k && jikan[j] >= 2) {
                    tmp = 0;
                }
            }
        }
        ans = max(ans, tmp);
    }

    ans.writeln;
}
