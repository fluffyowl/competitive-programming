import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0];
    auto K = s[1];
    auto M = s[2];

    long[long] F;
    for (long i = 2; i * i <= N; ++i) {
        while (N % i == 0) {
            N /= i;
            F[i] += 1;
        }
    }
    if (N > 1) {
        F[N] += 1;
    }

    foreach (k; F.keys) {
        F[k] *= K;
    }

    DList!long q1;
    DList!long q2;
    q1.insertBack(1);

    foreach (k; F.keys) {
        q2.clear();
        long tmp = 1;
        foreach (v; 0..F[k]+1) {
            if (tmp > M) break;
            foreach (n; q1) {
                if (tmp * n <= M) {
                    q2.insertBack(tmp * n);
                }
            }
            tmp *= k;
        }
        swap(q1, q2);
    }

    long ans = 0;
    foreach (n; q1) ans += 1;
    ans.writeln;
}
