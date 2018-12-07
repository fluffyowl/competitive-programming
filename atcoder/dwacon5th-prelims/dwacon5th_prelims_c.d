import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto Q = readln.chomp.to!int;
    auto K = readln.split.map!(to!int).array;

    foreach (k; K) {
        long d = 0;
        long m = 0;
        long dm = 0;
        long ans = 0;

        foreach (i; 0..k) {
            if (S[i] == 'D') {
                d += 1;
            } else if (S[i] == 'M') {
                m += 1;
                dm += d;
            } else if (S[i] == 'C') {
                ans += dm;
            }
        }

        foreach (i; k..N) {
            if (S[i-k] == 'D') {
                d -= 1;
                dm -= m;
            } else if (S[i-k] == 'M') {
                m -= 1;
            }

            if (S[i] == 'D') {
                d += 1;
            } else if (S[i] == 'M') {
                m += 1;
                dm += d;
            } else if (S[i] == 'C') {
                ans += dm;
            }
        }

        ans.writeln;
    }
}
