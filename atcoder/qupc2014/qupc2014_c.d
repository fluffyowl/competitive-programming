import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto Q = s[2];
    auto B = H.iota.map!(_ => readln.chomp).array;

    auto ans = new Tuple!(int, int)[](26);
    fill(ans, tuple(-1, -1));

    foreach (i; 0..H) foreach (j; 0..W) if (B[i][j] != '*') ans[B[i][j]-'A'] = tuple(i, j);

    while (Q--) {
        auto dd = readln.chomp;
        auto d = dd[0] - 'A';
        if (ans[d][0] == -1)
            writeln("NA");
        else
            writeln(ans[d][0] + 1, " ", ans[d][1] + 1);
    }
}
