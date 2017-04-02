import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

alias Tuple!(int, "x", int, "y", int, "c") Crystal;

void main() {
    auto s = readln.split.map!(to!int);
    auto Gx = s[0];
    auto Gy = s[1];
    auto N = s[2];
    auto F = s[3];
    auto C = new Crystal[](N);
    foreach (i; 0..N) {
        s = readln.split.map!(to!int);
        C[i] = Crystal(s[0], s[1], s[2]);
    }

    auto dp = new int[][][](N+1, Gx+1, Gy+1);

    foreach (x; 0..Gx+1) {
        foreach (y; 0..Gy+1) {
            dp[0][x][y] = (x + y) * F;
        }
    }

    foreach (i; 0..N) {
        foreach (x; 0..Gx+1) {
            foreach (y; 0..Gy+1) {
                dp[i+1][x][y] = dp[i][x][y];
                if (x - C[i].x < 0 || y - C[i].y < 0) continue;
                dp[i+1][x][y] = min(dp[i][x][y],
                                    dp[i][x-C[i].x][y-C[i].y] + C[i].c);
            }
        }
    }

    dp[N][Gx][Gy].writeln;
}

