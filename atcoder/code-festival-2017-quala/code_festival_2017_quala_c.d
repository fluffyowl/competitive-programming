import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;

    auto cnt = new int[](26);
    foreach (i; 0..H) foreach (j; 0..W) cnt[A[i][j] - 'a'] += 1;

    int r1 = 0, r2 = H - 1;
    int[] need = new int[](10);
    while (true) {
        if (r1 < r2) {
            need[4] += W / 2;
            need[2] += W % 2;
            r1 += 1;
            r2 -= 1;
        } else if (r1 == r2) {
            need[2] += W / 2;
            need[1] += W % 2;
            r1 += 1;
            r2 -= 1;
        }

        if (r1 > r2)
            break;
    }


    int odd = cnt.map!(c => c % 2 == 1).sum;
    if (odd != need[1]) {
        writeln("No");
        return;
    }

    if (need[1] == 1) foreach (i; 0..26) if (cnt[i] % 2 == 1) cnt[i] -= 1;

    foreach (i; 0..26) if (need[2] > 0 && cnt[i] % 4 == 2) need[2] -= 1, cnt[i] -= 2;
    if (cnt.map!(c => c % 4 == 0).all) {
        writeln("Yes");
    } else {
        writeln("No");
    }
}
