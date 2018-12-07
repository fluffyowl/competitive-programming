import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

alias Point = Tuple!(real, "X", real, "Y");
auto dr = [0, 0, 1, 1];
auto dc = [0, 1, 0, 1];

void main() {
    auto N = readln.chomp.to!long;
    auto m1 = Point(N * 0.5L, 0.0L);
    auto m2 = Point(N * 1.0L, N * 0.5L);
    auto m3 = Point(N * 0.5L, N * 1.0L);
    auto m4 = Point(0.0L    , N * 0.5);
    int ans = 0;

    foreach (r; 0..N) {
        foreach (c; 0..N) {
            int tmp = 1;
            foreach (i; 0..4) {
                auto P = Point((r+dr[i]).to!real, (c+dc[i]).to!real);
                if (product(m1, m2, P) < 0) tmp = 0;
                if (product(m2, m3, P) < 0) tmp = 0;
                if (product(m3, m4, P) < 0) tmp = 0;
                if (product(m4, m1, P) < 0) tmp = 0;
            }
            ans += tmp;
        }
    }
    ans.writeln;
}

real product(Point a, Point b, Point p) {
    auto vecab = Point(a.X - b.X, a.Y - b.Y);
    auto vecpa = Point(a.X - p.X, a.Y - p.Y);
    auto ext = vecab.X * vecpa.Y - vecpa.X * vecab.Y;
    return ext;
}
