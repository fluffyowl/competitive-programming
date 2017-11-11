import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto A = readln.chomp.to!int;
    auto S = readln.chomp;
    auto N = S.length.to!int;

    auto C = new int[](N);
    foreach (i; 0..N) C[i] = S[i] - 'a' + 1;

    foreach (i; 1..N) {
        int p = i + 1;
        int a = A;
        while (C[i - 1] + A <= 26) {
            if (C[i] > 0) {
                C[i - 1] += A;
                C[i] -= 1;
            } else if (p >= N) {
                break;
            } else if (C[p] == 0) {
                p += 1;
                a *= A;
                if (a > 25)
                    break;
            } else {
                C[p] -= 1;
                C[i] += a;
            }
        }
    }

    string ans = "";
    foreach (c; C) if (c != 0) ans ~= (c - 1 + 'a').to!char;
    ans.writeln;
}
