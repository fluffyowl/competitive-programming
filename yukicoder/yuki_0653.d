import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto P = readln.chomp.map!(c => (c - '0').to!int).array;
    P.reverse();
    int N = P.length.to!int;
    if (N == 1 || P[0] <= 1 || P[0] >= 5) {
        writeln("No");
        return;
    }


    bool owari1 = false;
    bool owari2 = false;

    foreach (i; 1..N) {
        if (owari2) {
            writeln("No");
            return;
        } else if (owari1) {
            if (P[i] != 6 && P[i] != 7) {
                writeln("No");
                return;
            }
        } else {
            if (P[i] == 1) {
                owari2 = true;
            } else if (P[i] == 7 || P[i] == 8) {
                owari1 = true;
            } else if (P[i] <= 2 || P[i] >= 6) {
                writeln("No");
                return;
            }
        }
    }

    if (!owari1 && !owari2 && P.back != 1) {
        writeln("No");
    } else {
        writeln("Yes");
    }
}

