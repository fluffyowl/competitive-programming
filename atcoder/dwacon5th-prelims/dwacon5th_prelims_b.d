import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto A = readln.split.map!(to!long).array;

    auto rbt = new RedBlackTree!(long, "a < b", true)();

    foreach (len; 1..N+1) {
        long tmp = 0;
        foreach (i; 0..len) {
            tmp += A[i];
        }
        rbt.insert(tmp);
        foreach (i; len..N) {
            tmp -= A[i-len];
            tmp += A[i];
            rbt.insert(tmp);
        }
    }


    foreach_reverse (b; 0..60) {
        long m = 1L << b;
        int cnt = 0;
        long[] to_remove;
        foreach (a; rbt) {
            if (a & m) {
                cnt += 1;
            } else {
                to_remove ~= a;
            }
        }
        if (cnt < K) {
            continue;
        }
        foreach (a; to_remove) {
            rbt.removeKey(a);
        }
    }

    long ans = (1L << 60) - 1;
    foreach (a; rbt) ans &= a;

    ans.writeln;
}
