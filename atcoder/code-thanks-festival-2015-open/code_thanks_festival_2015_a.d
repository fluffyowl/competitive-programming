import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;
    int ans;
    if (A * B >= 0) ans = max(abs(A), abs(B))*2;
    else ans = abs(A) * 2 + abs(B) * 2;
    ans.writeln;
}
