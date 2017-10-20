import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

long[] perm_prod(const long[] A, const long[] P) {
    auto ret = A.dup;
    foreach (i; 0..A.length) {
        ret[i] = A[P[i].to!int];
    }
    return ret;
}

long[] perm_pow(const long[] A, long x) {
    long[] P = A.dup;
    long[] ret = new long[](P.length);
    foreach (i; 0..P.length) ret[i] = i;
    while (x) {
        if (x % 2) ret = perm_prod(ret, P);
        P = perm_prod(P, P);
        x /= 2;
    }
    return ret;
}

void main() {
    auto N = readln.chomp.to!int;
    auto X = readln.split.map!(to!long).array;
    auto s = readln.split.map!(to!long);
    auto M = s[0].to!int;
    auto K = s[1];
    auto A = readln.split.map!(x => x.to!int - 1).array;

    auto D = new long[](N - 1);
    foreach (i; 0..N-1) D[i] = X[i + 1] - X[i];

    auto B = new long[](N - 1);
    foreach (i; 0..N-1) B[i] = i;
    foreach (i; 0..M) swap(B[A[i] - 1], B[A[i]]);

    B = perm_pow(B, K);
    D = perm_prod(D, B);

    auto ans = new long[](N);
    ans[0] = X[0];
    foreach (i; 0..N-1) ans[i + 1] = ans[i] + D[i];

    ans.each!writeln;
}
