import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable int INF = 2 * 10^^9;
int d;

bool is_kadomatsu(int a, int b, int c) {
    return ((a < b && b > c && a != c) || (a > b && b < c && a != c));
}

int rec(int h1, int h2, int h3) {
    if (h1 + h2 == 0 || h2 + h3 == 0 || h3 + h1 == 0)
        return INF;
    if (is_kadomatsu(h1, h2, h3))
        return 0;

    int d1 = INF, d2 = INF, d3 = INF;
    if (h1 - h2 >= 0) d1 = min(d1, h1 - h2);
    if (h1 - h3 >= 0) d1 = min(d1, h1 - h3);
    if (h2 - h1 >= 0) d2 = min(d2, h2 - h1);
    if (h2 - h3 >= 0) d2 = min(d2, h2 - h3);
    if (h3 - h1 >= 0) d3 = min(d3, h3 - h1);
    if (h3 - h2 >= 0) d3 = min(d3, h3 - h2);

    int ret1 = INF, ret2 = INF, ret3 = INF;
    if (d1 < INF) {
        ret1 = rec(max(0, h1 - (d1/d+1)*d), h2, h3);
        if (ret1 != INF) ret1 += d1/d+1;
    }
    if (d2 < INF) {
        ret2 = rec(h1, max(0, h2 - (d2/d+1)*d), h3);
        if (ret2 != INF) ret2 += d2/d+1;
    }
    if (d3 < INF) {
        ret3 = rec(h1, h2, max(0, h3 - (d3/d+1)*d));
        if (ret3 != INF) ret3 += d3/d+1;
    }

    return [ret1, ret2, ret3].reduce!(min);
}

void main() {
    int a, b, c;
    scanf("%d %d %d %d", &d, &a, &b, &c);

    if (d == 0) {
        writeln(is_kadomatsu(a, b, c) ? 0 : -1);
        return;
    }

    int ans = rec(a, b, c);
    writeln(ans == INF ? -1 : ans);
}

