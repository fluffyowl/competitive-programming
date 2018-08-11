import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto t = readln.split.map!(to!int);
    auto N = t[0];
    auto M = t[1];
    auto R = N.iota.map!(_ => readln.split.map!(to!int).array).array;

    int ans = 0;
    auto C = new int[](N);
    auto S = new int[][](M);
    auto V = new int[](M);
    V.fill(-1);

    foreach (i; 0..N) {
        foreach (j; 0..M) {
            if (R[i][j] > V[j]) {
                foreach (s; S[j]) {
                    C[s] -= 1;
                    if (C[s] == 0) ans -= 1;
                }
                S[j] = [i];
                C[i] += 1;
                V[j] = R[i][j];
            } else if (R[i][j] == V[j]) {
                S[j] ~= i;
                C[i] += 1;
            }
        }
        if (C[i] > 0) {
            ans += 1;
        }
        ans.writeln;
    }
}

