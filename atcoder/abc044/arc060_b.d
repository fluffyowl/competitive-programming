import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

long digit_sum(long b, long n) {
    if (n < b)
        return n;
    else
        return digit_sum(b, n/b) + n % b;
}

void main() {
    auto N = readln.chomp.to!long;
    auto S = readln.chomp.to!long;

    if (N == S) {
        writeln(N+1);
        return;
    }


    for (long b = 2; b * b <= N; b++) {
        if (digit_sum(b, N) == S) {
            writeln(b);
            return;
        }
    }

    long ans = long.max;

    for (long p = 1; p * p <= N; p++) {
        if ((p-S+N) % p != 0)
            continue;
        long b = (p-S+N) / p;
        if (b > 1 && digit_sum(b, N) == S)
            ans = min(ans, b);

    }

    writeln(ans == long.max ? -1 : ans);
}
