import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto L = s[1];
    auto R = s[2];
    auto A = N.iota.map!(i => readln.split.map!(to!int).array ~ i).array;
    auto used = new bool[](5000);
    A.sort!"a[3] > b[3]";
    auto ans = new int[](N);

    foreach (j, a; A.enumerate) {
        bool ok = false;
        foreach (i; max(a[0], L)..min(a[2]+1, R+1)) if (!used[i]) {ok = true; break;}
        if (!ok) continue;
        foreach (i; max(a[0], L)..min(a[2]+1, R+1)) used[i] = true;
        ans[a[4]] = 1;
    }
    ans.each!writeln;
}

