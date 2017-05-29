import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto X = readln.split.map!(to!long).array;
    auto A = X[0..N];
    auto B = X[N..2*N];
    auto C = X[2*N..$];

    A.sort();
    C.sort();

    auto a_sum = new long[](N+1);
    auto c_sum = new long[](N+1);
    a_sum[0] = A.sum;
    c_sum[N] = C.sum;

    auto a_rbt = new RedBlackTree!(long, "a < b", true)();
    foreach (i; 0..N) a_rbt.insert(A[i]);

    foreach (i; 0..N) {
        long mn = a_rbt.front;
        a_sum[i+1] = a_sum[i];
        if (mn < B[i]) {
            a_sum[i+1] = a_sum[i+1] - mn + B[i];
            a_rbt.removeKey(mn);
            a_rbt.insert(B[i]);
        }
    }

    auto c_rbt = new RedBlackTree!(long, "a > b", true)();
    foreach (i; 0..N) c_rbt.insert(C[i]);

    foreach (i; iota(N-1, -1, -1)) {
        long mx = c_rbt.front;
        c_sum[i] = c_sum[i+1];
        if (mx > B[i]) {
            c_sum[i] = c_sum[i] - mx + B[i];
            c_rbt.removeKey(mx);
            c_rbt.insert(B[i]);
        }
    }

    long ans = - (1L << 60);
    foreach(i; 0..N+1) {
        ans = max(ans, a_sum[i] - c_sum[i]);
    }

    ans.writeln;
}
