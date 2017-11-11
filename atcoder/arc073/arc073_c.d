import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


immutable long INF = 1L << 59;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    foreach (i; 0..N) A[i].sort();
    auto Amax = A.map!(a => a.reduce!max).reduce!max;
    auto Amin = A.map!(a => a.reduce!min).reduce!min;


    long solve1() { // Rmax, Rmin = Amax, Amin
        int cnt = 0;
        foreach (i; 0..N) if (A[i][0] == Amin || A[i][1] == Amax) cnt += 1;
        if (cnt <= 1) return INF;

        long Bmax = -INF;
        long Bmin = INF;
        foreach (i; 0..N) {
            if (A[i][0] == Amin) Bmax = max(Bmax, A[i][1]), Bmin = min(Bmin, A[i][1]);
            if (A[i][1] == Amax) Bmax = max(Bmax, A[i][0]), Bmin = min(Bmin, A[i][0]);
        }

        auto B = A.filter!(a => a[0] != Amin && a[1] != Amax).array;
        if (B.length == 0) return (Amax - Amin) * (Bmax - Bmin);
        B.sort();
        long bmax = B.back[0];
        long bmin = B.front[0];
        long ans = (Amax - Amin) * (max(Bmax, bmax) - min(Bmin, bmin));

        foreach (i; 0..B.length.to!int) {
            bmin = i == B.length.to!int - 1 ? INF : B[i+1][0];
            Bmax = max(Bmax, B[i][1]);
            Bmin = min(Bmin, B[i][1]);
            ans = min(ans, (Amax - Amin) * (max(Bmax, bmax) - min(Bmin, bmin)));
        }

        return ans;
    }


    long solve2() { // Rmax = Amax, Bmin = Amin
        long Rmin = A.map!(a => a[1]).reduce!min;
        long Bmax = A.map!(a => a[0]).reduce!max;
        return (Amax - Rmin) * (Bmax - Amin);
    }

    min(solve1, solve2).writeln;
}
