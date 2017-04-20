import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto s = readln.split;
        auto S = s[0];
        auto T = s[1];
        for (char i = 'a'; i <= 'z'; i++) {
            if (indexOf(T, i.to!string) == -1) S = S.replace(i.to!string, "");
        }
        writeln(indexOf(S, T) != -1 ? "YES" : "NO");
    }
}
