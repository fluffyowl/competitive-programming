import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Y = s[1];

    for (int i = 0; i * 10000 <= Y && i <= N; ++i) {
        for (int j = 0; i * 10000 + j * 5000 <= Y && i + j <= N; ++j) {
            int k = Y - i*10000 - j*5000;
            if (i + j + k/1000 == N) {
                writeln(i, " ", j, " ", k/1000);
                return;
            }
        }
    }

    writeln(-1, " ", -1, " ", -1);
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto Y = s[1];

    for (int i = 0; i * 10000 <= Y && i <= N; ++i) {
        for (int j = 0; i * 10000 + j * 5000 <= Y && i + j <= N; ++j) {
            int k = Y - i*10000 - j*5000;
            if (i + j + k/1000 == N) {
                writeln(i, " ", j, " ", k/1000);
                return;
            }
        }
    }

    writeln(-1, " ", -1, " ", -1);
}
