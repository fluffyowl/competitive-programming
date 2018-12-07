import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

int N, K;
int[] A;

void write_answer(const int[][] ans) {
    foreach (a; ans) {
        writeln(a[0] + 1, " ", a[1] + 1, " ", a[2] + 1, " ", a[3] + 1, " ", a[4]);
    }
}

int score(const int[] X) {
    return N.iota.map!(i => abs(A[i] - i)).sum;
}

int[][] search() {
    auto diff = N.iota.map!(i => A[i] - i).array;
    int[][int] diff_index;
    foreach (i; 0..N) diff_index[diff[i]] ~= i;

    int[][] ret;

    for (int mn = -N, mx = N; ret.length < K; ) {
        while (mn !in diff_index || diff_index[mn].empty) ++mn;
        int x = diff_index[mn].back;
        diff_index[mn].popBack;
        while (mx !in diff_index || diff_index[mx].empty) --mx;
        int y = diff_index[mx].back;
        diff_index[mx].popBack;

        int best_score = abs(x - A[x]) + abs(y - A[y]);
        int best_v = 0;

        for (int v = min(abs(mn), abs(mx)); v <= max(abs(mn), abs(mx)); ++v) {
            if (A[x] + v >= N || A[y] - v < 0) continue;
            int score = abs(x - (A[x] + v)) + abs(y - (A[y] - v));
            if (score < best_score) {
                best_score = score;
                best_v = v;
            }
        }

        int v = best_v;
        ret ~= [y, y, x, x, v];
        diff_index[mn+v] ~= x;
        diff_index[mx-v] ~= y;
        A[x] += v;
        A[y] -= v;
    }

    return ret;
}

void main() {
    auto s = readln.split.map!(to!int);
    N = s[0];
    K = s[1];
    A = N.iota.map!(_ => readln.chomp.to!int - 1).array;

    auto ans = search;
    write_answer(ans);

    debug {
        A.writeln;
        score(A).writeln;
        foreach (a; ans) {
            foreach (i; a[0]..a[1]+1) A[i] -= a[4];
            foreach (i; a[2]..a[3]+1) A[i] += a[4];
        }
        A.writeln;
        score(A).writeln;
    }
}
