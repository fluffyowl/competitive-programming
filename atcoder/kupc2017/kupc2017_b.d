import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto S = s[1];
    auto T = s[2];

    if (S > T) {
        writeln(-1);
        return;
    } else if (S == T) {
        writeln(0);
        return;
    }

    int a = bsr(S);
    int ans = 0;

    while (bsr(S) < bsr(T)) S <<= 1, ans += 1;

    foreach (i; 0..a) {
        int j = bsr(S) - i;
        if ((S & (1 << j)) != (T & (1 << j))) {
            writeln(-1);
            return;
        }
    }

    ans.writeln;
}
