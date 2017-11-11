import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    int ans = 0;

    for (int p = 0, q = N-1; p < q; ) {
        if (S[p] == S[q]) {
            p += 1;
            q -= 1;
        } else if (S[p] == 'x') {
            ans += 1;
            p += 1;
        } else if (S[q] == 'x') {
            ans += 1;
            q -= 1;
        } else {
            writeln(-1);
            return;
        }
    }

    ans.writeln;
}
