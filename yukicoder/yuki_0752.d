import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!long);
    auto P = s[0];
    auto Q = s[1];

    long[] A;
    long[] B;

    for (long i = 1; ; ) {
        A ~= i;
        B ~= P / i;
        if (B.back == 0) break;
        long lo = i;
        long hi = P + 10;
        while (hi - lo > 1) {
            long mid = (hi + lo) / 2;
            if (P / mid == P / i) lo = mid;
            else hi = mid;
        }
        i = hi;
    }

    int N = A.length.to!int;
    long[] C = new long[](N-1);
    long[] D = new long[](N);
    foreach (i; 0..N-1) {
        long n = A[i+1] - A[i];
        long a = P % A[i];
        long d = -P / A[i];
        C[i] = n * (2 * a + (n - 1) * d) / 2;
        D[i+1] = D[i] + C[i];
    }

    int bs(long n) {
        int lo = 0;
        int hi = N;
        while (hi - lo > 1) {
            int mid = (hi + lo) / 2;
            if (P / n > B[mid]) hi = mid;
            else lo = mid;
        }
        return lo;
    }

    while (Q--) {
        s = readln.split.map!(to!long);
        auto L = s[0];
        auto R = s[1];
        long ans = 0;
        if (L > P) {
            writeln((R - L + 1) * P);
            continue;
        }
        if (R > P) {
            ans += (R - P) * P;
            R = P;
        }
        int bsL = bs(L);
        int bsR = bs(R);
        long n, a, d;
        if (bsL == bsR) {
            n = R - L + 1;
            a = P % L;
            d = - P / L;
            ans += n * (2 * a + (n - 1) * d) / 2;
            ans.writeln;
            continue;
        }
        if (bsR - bsL >= 2) {
            ans += D[bsR] - D[bsL+1];
        }
        n = A[bsL+1] - L;
        a = P % L;
        d = -P / L;
        ans += n * (2 * a + (n - 1) * d) / 2;
        n = R - A[bsR] + 1;
        a = P % A[bsR];
        d = -P / A[bsR];
        ans += n * (2 * a + (n - 1) * d) / 2;
        ans.writeln;
    }
}

