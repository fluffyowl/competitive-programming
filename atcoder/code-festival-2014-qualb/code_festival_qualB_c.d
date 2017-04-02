import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto S = [readln.chomp, readln.chomp, readln.chomp];
    auto N = S[0].length;
    auto D = new int[][](3, 26);
    foreach (i; 0..3) {
        foreach (j; 0..N) {
            D[i][S[i][j]-'A'] += 1;
        }
    }

    int upper1, lower1, upper2, lower2;

    foreach (i; 0..26) {
        if (D[0][i] + D[1][i] < D[2][i]) {
            writeln("NO");
            return;
        }

        upper1 += min(D[0][i], D[2][i]);
        lower1 += max(0, D[2][i]-D[1][i]);
        upper2 += min(D[1][i], D[2][i]);
        lower2 += max(0, D[2][i]-D[0][i]);
    }

    if (upper1 >= N/2 && lower1 <= N/2 && upper2 >= N/2 && lower2 <= N/2) {
        writeln("YES");
    }
    else {
        writeln("NO");
    }
}
