import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1].to!long;
    auto A = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    Tuple!(long, long)[] B;
    long ans = 0;

    foreach (i; 0..N) {
        if (K >= A[i][0]) B ~= tuple(A[i][0], A[i][1]);
    }

    for (int b = bsr(K); b >= 0; --b) {
        long tmp = 0;
        Tuple!(long, long)[] C;
        bool k = (K & (1L << b)) > 0;
        if (k) {
            foreach (i; 0..B.length) {
                bool a = (B[i][0] & (1L << b)) > 0;
                if (!a) tmp += B[i][1];
            }
        } else {
            foreach (i; 0..B.length) {
                bool a = (B[i][0] & (1L << b)) > 0;
                if (!a) C ~= B[i];
            }
            B = C.dup;
        }
        ans = max(tmp, ans);
    }

    ans = max(ans, B.map!(b => b[1]).sum);
    ans.writeln;
}
