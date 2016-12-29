import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto M = readln.chomp.to!int;
    auto P = M.iota.map!(_ => readln.split.map!(to!int).array).array;

    writeln("? 0 0");
    stdout.flush;
    auto dxdy = readln.split.map!(to!int).array;

    writeln("? 1 0");
    stdout.flush;
    auto C = readln.split.map!(to!int).array;

    auto cos = C[0] - dxdy[0];
    auto sin = C[1] - dxdy[1];

    writeln("!");
    foreach (p; P) {
        auto x = p[0] * cos - p[1] * sin + dxdy[0];
        auto y = p[0] * sin + p[1] * cos + dxdy[1];
        writeln(x, " ", y);
    }
    stdout.flush;
}

