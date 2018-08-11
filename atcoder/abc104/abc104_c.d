import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto D = s[0];
    auto G = s[1].to!long;
    auto PC = D.iota.map!(_ => readln.split.map!(to!long).array).array;
    int ans = 1 << 29;

    foreach (mask; 0..(1<<D)) {
        long tmp = 0;
        int cnt = 0;
        foreach (i; 0..D) {
            if (mask & (1 << i)) {
                tmp += PC[i][0] * (i + 1) * 100 + PC[i][1];
                cnt += PC[i][0];
            }
        }
        for (int i = D-1; i >= 0 && tmp < G; --i) {
            if (mask & (1 << i)) continue;
            long hoge = (G - tmp - 1) / ((i + 1) * 100) + 1;
            hoge = min(hoge, PC[i][0]);
            tmp += hoge * (i + 1) * 100;
            cnt += hoge;
        }
        if (tmp >= G) ans = min(ans, cnt);
    }

    ans.writeln;
}
