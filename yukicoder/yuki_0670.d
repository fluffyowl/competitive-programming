import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

ulong seed;
int next() {
    seed = seed ^ (seed << 13);
    seed = seed ^ (seed >> 7);
    seed = seed ^ (seed << 17);
    return cast(int)(seed >> 33);
}

void main() {
    immutable long M = 2L ^^ 31;
    immutable long T = 20000;

    int N, Q;
    readf("%d %d %d\n", &N, &Q, &seed);
    foreach (i; 0..10000) next();

    long[] A = new long[N];
    foreach (i; 0..N) A[i] = next();
    A.sort();

    long[] B = new long[M/T+10];

    for (long i = 0, p = 0; i * T <= M+1; ++i) {
        while (p < N && A[p.to!int] < i * T) ++p;
        B[i.to!int] = p;
    }

    long ans = 0;
    foreach (i; 0..Q) {
        long q = next();
        long a = q - q % T;
        long b = q - q % T + T;
        if (B[a/T] == B[b/T]) {
            ans ^= B[a/T] * i;
        } else {
            long tmp = B[a/T];
            for (long j = B[a/T]; j < N && A[j] < q; ++j) ++tmp;
            ans ^= tmp * i;
        }
    }

    ans.writeln;
}

