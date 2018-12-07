import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;

    auto B = new long[](N+1);
    foreach (i; 0..N) B[i+1] = B[i] + A[i];

    long ans = 1L << 59;
    long left = 0;
    long right = 0;
    long[long] cl;
    long[long] cr;
    cl[0] = 1;
    cr[B[N]] = 1;

    foreach_reverse (i; 0..N) {
        if (B[i] in cr) {
            right += cr[B[i]];
        }
        cr[B[i]] += 1;
    }

    foreach (i; 0..N) {
        cr[B[i]] -= 1;
        right -= cr[B[i]];
        ans = min(ans, left + right);
        if (B[i+1] in cl) {
            left += cl[B[i+1]];
        }
        cl[B[i+1]] += 1;
    }

    ans.writeln;
}
