import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto PY = M.iota.map!(_ => readln.split.map!(to!int).array).array;

    auto X = new Tuple!(int, int)[][](N+1);
    foreach (i; 0..M) X[PY[i][0]] ~= tuple(i, PY[i][1]);
    foreach (i; 0..N+1) X[i].sort!"a[1] < b[1]";

    auto ans = new string[](M);
    foreach (j; 0..N+1) {
        foreach (i; 0..X[j].length.to!int) {
            ans[X[j][i][0]] = (format("%06d", j)) ~ (format("%06d", i + 1));
        }
    }

    ans.each!writeln;
}
