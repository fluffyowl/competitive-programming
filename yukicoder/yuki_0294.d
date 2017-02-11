import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {

    auto N = readln.chomp.to!int;

    auto nck = new int[][](31, 31);

    nck[0][0] = nck[1][0] = nck[1][1] = 1;
    foreach (i; 2..31)
        foreach (j; 0..i+1)
            nck[i][j] = (i == j || j == 0) ? 1 : nck[i-1][j-1] + nck[i-1][j];

    int acm, keta;

    foreach (i; 3..31) {
        int incr = 0;
        foreach (j; iota(2, i, 3)) {
            incr += nck[i-1][j];
        }
        if (acm + incr >= N) {
            keta = i.to!int;
            break;
        }
        acm += incr;
    }


    foreach (i; 0..(1<<(keta-1))) {
        if (i.popcnt % 3 == 2) acm++;
        if (acm == N) {
            string ans = "5";
            foreach (j; 0..keta-1) {
                ans = ((i & (1 << j)) ? "5" : "3") ~ ans;
            }
            ans.writeln;
            break;
        }
    }
}
