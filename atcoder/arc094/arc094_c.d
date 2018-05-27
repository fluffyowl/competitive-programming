import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto AB = N.iota.map!(_ => readln.split.map!(to!long).array).array;
    if (AB.filter!(a => a[0] > a[1]).empty) {
        0.writeln;
    } else {
        writeln(AB.map!(a => a[1]).sum - AB.filter!(a => a[0] > a[1]).map!(a => a[1]).reduce!min);
    }
}
