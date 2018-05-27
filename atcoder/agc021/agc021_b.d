import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

alias Point = Tuple!(long, "x", long, "y", int, "i");

void main() {
    
    auto N = readln.chomp.to!int;
    auto P = new Point[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!int);
        P[i] = Point(s[0], s[1], i);
    }
    
    P.sort!((a, b) => a.x == b.x ? a.y < b.y : a.x < b.x);
    Point[] ch1, ch2;
    foreach (i; 0..N) {
        while (ch1.length >= 2 && rot(ch1[$-2], ch1[$-1], P[i]) <= 0) ch1.popBack;
        ch1 ~= P[i];
    }
    foreach_reverse (i; 0..N) {
        while (ch2.length >= 2 && rot(ch2[$-2], ch2[$-1], P[i]) <= 0) ch2.popBack;
        ch2 ~= P[i];
    }

    auto ch = ch1 ~ ch2;
    ch = ch.uniq.array;
    ch.popBack;
    int M = ch.length.to!int;

    auto ans = new real[](N);
    ans.fill(0);

    foreach (i; 0..M) {
        auto a = ch[(i-1+M)%M];
        auto b = ch[i];
        auto c = ch[(i+1)%M];
        ans[ch[i].i] = PI - angle(a, b, c);
    }

    if (M == 2) {
        ans[ch[0].i] = 0.5;
        ans[ch[1].i] = 0.5;
    }

    foreach (a; ans) {
        writefln("%.09f", a / ans.sum);
    }
}

real angle(Point a, Point b, Point c) {
    auto a1 = a.x - b.x;
    auto a2 = a.y - b.y;
    auto c1 = c.x - b.x;
    auto c2 = c.y - b.y;
    auto cs = (a1 * c1 + a2 * c2) / (sqrt(1.0L*a1*a1+a2*a2) * sqrt(1.0L*c1*c1+c2*c2));
    return acos(cs);
}

long rot(Point a, Point b, Point c) {
    // a -> b -> c の向き
    // 正なら左、負なら右、0なら同一直線状
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
}

long dist2(Point a, Point b) {
    return (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y);
}
