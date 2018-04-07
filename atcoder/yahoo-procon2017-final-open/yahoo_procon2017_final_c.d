import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable int D = 320;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto Q = s[2];
    auto A = readln.split.map!(a => a.to!int % M).array;

    auto SIZE = N / D + 1;
    auto sd_sum = new int[](SIZE);
    auto sd_cnt = new int[][](SIZE, M);

    foreach (i; 0..N) {
        sd_cnt[i/D][A[i]] += 1;
    }

    int add(int a, int b, int x) { // a <= i <= b に x を加算
        int ret = 0;
        for (int i = 0, l = 0, r = D-1; i < SIZE; i += 1, l += D, r += D) {
            if (a <= l && r <= b) {
                sd_sum[i] += x;
                sd_sum[i] %= M;
                ret += sd_cnt[i][(M - sd_sum[i] + M) % M];
            } else if ((l <= a && a <= r) || (l <= b && b <= r)) {
                for (int j = max(a, l); j <= min(b, r, N-1); ++j) {
                    sd_cnt[i][A[j]] -= 1;
                    A[j] += x;
                    A[j] %= M;
                    sd_cnt[i][A[j]] += 1;
                    if ((A[j] + sd_sum[i]) % M == 0) ret += 1;
                }
            }
        }
        return ret;
    }

    while (Q--) {
        s = readln.split.map!(to!int);
        int l = s[0]-1;
        int r = s[1]-1;
        int x = s[2]%M;
        add(l, r, x).writeln;
        debug {
            sd_sum.writeln;
            sd_cnt.writeln;
            A.writeln;
        }
    }
}
