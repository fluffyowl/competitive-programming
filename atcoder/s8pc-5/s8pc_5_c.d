import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto T = readln.chomp.to!int;
    while (T--) solve;
}

void solve() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    int A1 = N / 4;
    int A2 = 0;
    int B1 = 0;
    int B2 = N / 4;
    bool ok = true;

    foreach (i; 0..N) {
        if (S[i] == '(' && A1 > 0) {
            A1 -= 1;
            A2 += 1;
        } else if (S[i] == '(' && A1 == 0) {
            if (B1 == 0) {
                ok = false;
                break;
            }
            B1 -= 1;
        } else if (S[i] == ')' && B2 > 0) {
            B2 -= 1;
            B1 += 1;
        } else {
            if (A2 == 0) {
                ok = false;
                break;
            }
            A2 -= 1;
        }
    }

    writeln(ok ? "Yes" : "No");
}
