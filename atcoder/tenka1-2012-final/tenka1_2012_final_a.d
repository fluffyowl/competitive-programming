import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    long N = readln.chomp.to!long;

    long[] F;
    F ~= [0, 1, 1];
    for (long i = 2; F.back < N; ++i) F ~= F[$-2] + F[$-1];

    int ans = 0;
    for (int i = F.length.to!int-1; N > 0; ) {
        if (F[i] > N) {
            i -= 1;
            continue;
        } else {
            N -= F[i];
            ans += 1;
        }
    }

    ans.writeln;
}
