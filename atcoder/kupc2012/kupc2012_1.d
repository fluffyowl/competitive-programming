import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto T = s[1];
    auto E = s[2];
    auto A = readln.split.map!(to!int).array;

    foreach (i; 0..N) {
        for (int x = A[i]; x <= T+E; x += A[i]) {
            if (x >= T-E && x <= T+E) {
                writeln(i+1);
                return;
            }
        }
    }

    writeln(-1);
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto T = s[1];
    auto E = s[2];
    auto A = readln.split.map!(to!int).array;

    foreach (i; 0..N) {
        for (int x = A[i]; x <= T+E; x += A[i]) {
            if (x >= T-E && x <= T+E) {
                writeln(i+1);
                return;
            }
        }
    }

    writeln(-1);
}
