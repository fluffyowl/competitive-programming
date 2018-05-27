import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    int[] dr = [1, -1, 0, 0];
    int[] dc = [0, 0, 1, -1];

    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;

    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (A[i][j] != '#') continue;
            bool ok = false;
            foreach (k; 0..4) {
                int di = i + dr[k];
                int dj = j + dc[k];
                if (di < 0 || di >= H || dj < 0 || dj >= W) continue;
                if (A[di][dj] == '#') ok = true;
            }
            if (!ok) {
                writeln("No");
                return;
            }
        }
    }

    writeln("Yes");
}
