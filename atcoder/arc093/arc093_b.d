import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    immutable int N = 100;
    auto s = readln.split.map!(to!int);
    auto A = s[0] - 1;
    auto B = s[1] - 1;
    auto C = new bool[][](100, 100);

    foreach (i; 0..N) C[i][99] = true;

    // 横線
    for (int i = 3; i < N-1 && A > 0; i += 4, A -= 1) {
        C[i].fill(true);
    }

    // 縦線
    for (int j = 3; j < N && A > 0; j += 4) {
        for (int i = 0; i < N && A > 0; i += 4, A-= 1) {
            foreach (k; i..i+4) {
                C[k][j] = true;
            }
        }
    }

    for (int i = 1; i < N && B > 0; i += 4) {
        for (int j = 1; j < N && B > 0; j += 4, B -= 1) {
            C[i][j] = true;
        }
    }

    writeln(100, " ", 100);
    C.each!(c => c.map!(cc => cc ? "#" : ".").join("").writeln);
}
