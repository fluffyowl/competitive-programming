import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto M = s[2];
    auto N = readln.chomp.to!int;
    auto Q = N.iota.map!(_ => readln.split.map!(to!int).array).array;
    auto A = new int[][](H, W+1);

    foreach (q; Q) {
        foreach (i; q[0]-1..q[1]) {
            A[i][q[2]-1] += 1;
            A[i][q[3]] -= 1;
        }
    }

    foreach (i; 0..H) {
        foreach (j; 0..W) {
            A[i][j+1] += A[i][j];
        }
    }

    foreach (x, q; Q.enumerate) {
        int ans = 0;
        foreach (i; 0..H) {
            foreach (j; 0..W) {
                int a = A[i][j];
                if (q[0]-1 <= i && i <= q[1]-1 && q[2]-1 <= j && j <= q[3]-1) a -= 1;
                if (a % 4 == 0) ans += 1;
            }
        }
        if (ans == M) (x+1).writeln;
    }


}
