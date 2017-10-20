import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    int odd, two, four;
    foreach (a; A) {
        if (a % 2 == 1) odd += 1;
        else if (a % 4 == 0) four += 1;
        else two += 1;
    }

    int mode = 0;
    foreach (i; 0..N) {
        if (mode == 0) {
            if (odd > 0) odd -= 1, mode = 4;
            else if (two > 0) two -= 1, mode = 2;
            else four -= 1, mode = 0;
        } else if (mode == 2) {
            if (two > 0) two -= 1, mode = 2;
            else if (four > 0) four -= 1, mode = 0;
            else {writeln("No"); return;}
        } else if (mode == 4) {
            if (four > 0) four -= 1, mode = 0;
            else {writeln("No"); return;}
        }
    }

    writeln("Yes");
}
