import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const int zero = false;
const int one  = true;
const int two = one << one;


void main() {
    int N = readln.chomp.to!int;

    if (N == one) {
        "NO".writeln;
        return;
    }

    foreach (i; two..N) {
        if (N % i == zero) {
            "NO".writeln;
            return;
        }
    }

    "YES".writeln;
}

