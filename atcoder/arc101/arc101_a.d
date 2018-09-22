import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(to!long).array;
    long x, y;
    int cnt = 0;
    int first = N;
    int zero = -1;

    foreach (i; 0..N) {
        if (A[i] == 0) {
            zero = i;
            break;
        }
    }
    if (zero != -1) {
        A.remove(zero);
        N -= 1;
        K -= 1;
    }

    if (K == 0) {
        writeln(0);
        return;
    }

    foreach (i; 0..N) {
        if (A[i] >= 0) {
            first = i;
            break;
        }
    }

    if (first == N) {
        writeln(-A[N-K]);
        return;
    }


    int bk = max(first - K, 0);
    long ans = 1L << 59;
    if (first - K >= 0) ans = min(ans, -A[bk]);
    if (first + K - 1 < N) ans = min(ans, A[first + K - 1]);
    foreach (i; first..N) {
        int len = i - bk + 1;
        if (len < K) continue;
        if (len > K) bk += 1;
        if (A[bk] > 0) continue;
        long x1 = A[i] * 2 - A[bk];
        long x2 = - A[bk] * 2 + A[i];
        ans = min(ans, x1, x2);
    }

    ans.writeln;
}
