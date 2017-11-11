import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

const int INF = 1 << 29;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto D = s[1];
    s = readln.split.map!(to!int);
    auto X = s[0];
    auto Y = s[1];

    if (X % D != 0 || Y % D != 0) {
        writeln(0);
        return;
    }

    int yoko = abs(X / D);
    int tate = abs(Y / D);
    real ans = 0;

    foreach (x; 0..N+1) { // 横移動の回数
        int y = N - x;
        if (x < yoko || y < tate) continue;
        if ((x + yoko) % 2 != 0 || (x - yoko) % 2 != 0) continue;
        if ((y + tate) % 2 != 0 || (y - tate) % 2 != 0) continue;
        int[] bunbo = N.iota.map!(_ => 4).array;
        real tmp = 1;
        int a = (x + yoko) / 2;
        int b = (x - yoko) / 2;
        int c = (y + tate) / 2;
        int d = (y - tate) / 2;
        foreach (i; 2..a+1) bunbo ~= i;
        foreach (i; 2..b+1) bunbo ~= i;
        foreach (i; 2..c+1) bunbo ~= i;
        foreach (i; 2..d+1) bunbo ~= i;
        foreach (i; 2..N+1) {
            int bb = 1;
            if (!bunbo.empty) {
                bb = bunbo.back;
                bunbo.popBack;
            }
            tmp *= 1.0L * i / bb;
        }
        while (!bunbo.empty) {
            tmp /= 1.0L * bunbo.back;
            bunbo.popBack;
        }
        ans += tmp;
    }



    writefln("%.12f", ans);
}
