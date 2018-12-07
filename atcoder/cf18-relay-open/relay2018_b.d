import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

int[] dx = [0, 0, -1, 1];
int[] dy = [-1, 1, 0, 0];

void main() {
    auto S = readln.chomp.map!(c => (c - 'W').to!int).array;
    auto s = readln.split.map!(to!int);
    auto gx = s[0];
    auto gy = s[1];

    if (gx == 0 && gy == 0) {
        writeln("Yes");
        return;
    }

    auto a = [0, 1, 2, 3];
    do {
        int x = 0;
        int y = 0;
        foreach (i; S) {
            x += dx[a[i]];
            y += dy[a[i]];
            if (x == gx && y == gy) {
                writeln("Yes");
                return;
            }
        }
    } while (nextPermutation(a));

    writeln("No");
}
