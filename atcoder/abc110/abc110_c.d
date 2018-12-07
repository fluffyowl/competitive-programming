import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

void main() {
    auto S = readln.chomp;
    auto T = readln.chomp;
    int N = S.length.to!int;

    auto ss = new int[][](26);
    auto tt = new int[][](26);

    foreach (i; 0..N) ss[S[i] - 'a'] ~= i;
    foreach (i; 0..N) tt[T[i] - 'a'] ~= i;

    ss = ss.filter!(a => !a.empty).array;
    tt = tt.filter!(a => !a.empty).array;

    ss.sort!"a.front < b.front";
    tt.sort!"a.front < b.front";


    foreach (i; 0..ss.length) {
        if (ss[i] != tt[i]) {
            writeln("No");
            return;
        }
    }

    writeln("Yes");
}
