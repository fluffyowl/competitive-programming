import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto B = new long[](N+1);
    foreach (i; 0..N) B[i+1] = B[i] + A[i];

    bool solve(bool t, int l, int r) {
        if (r == l)
            return t;
        if (A[l] == A[r])
            return t;

        long a = B[r+1] - B[l];
        int hi = r;
        int lo = l - 1;
        while (hi - lo > 1) {
            int mid = (hi + lo) / 2;
            if (A[mid] * (r - l + 1) >= a) {
                hi = mid;
            } else {
                lo = mid;
            }
        }

        if (!t)
            return !(!solve(t^1, l, hi-1) || !solve(t^1, hi, r));
        else
            return solve(t^1, l, hi-1) || solve(t^1, hi, r);
    }

    writeln(solve(0, 0, N-1) ? "Second" : "First");
}

