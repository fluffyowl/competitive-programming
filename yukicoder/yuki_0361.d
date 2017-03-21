import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split.map!(to!int);
    auto L = s[0];
    auto D = s[1];

    auto grundy = new int[](L+1);
    foreach (i; 6..L+1) {
        bool[int] mex;
        foreach (a; 1..i) {
            foreach (b; a+1..i) {
                auto c = i - a - b;
                if (c <= b || c - a > D) continue;
                mex[grundy[a] ^ grundy[b] ^ grundy[c]] = true;
            }
        }

        for (int j = 0; ; j++) {
            if (!(j in mex)) {
                grundy[i] = j;
                break;
            }
        }

    }

    writeln(grundy[L] == 0 ? "matsu" : "kado");
}

