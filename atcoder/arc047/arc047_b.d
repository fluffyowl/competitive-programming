import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


alias Tuple!(int, "x", int, "y") Point;

Point rotate45(Point p) {
    return Point(p.x-p.y, p.x+p.y);
}

Point rotate45back(Point p) {
    return Point((p.x+p.y)/2, (-p.x+p.y)/2);
}

void main() {
    auto N = readln.chomp.to!int;
    auto P = new Point[](N);
    foreach (i; 0..N) {
        auto s = readln.split.map!(to!int);
        P[i] = Point(s[0], s[1]);
    }
    auto R = P.map!(rotate45).array;

    auto x0 = R.map!(r => r.x).reduce!(min);
    auto x1 = R.map!(r => r.x).reduce!(max);
    auto y0 = R.map!(r => r.y).reduce!(min);
    auto y1 = R.map!(r => r.y).reduce!(max);

    Point ans;

    auto d = max(x1-x0, y1-y0) / 2;
    auto cand = [Point(x0+d, y0+d), Point(x1-d, y0+d), Point(x0+d, y1-d)];
    foreach (i; 0..3) {
        ans = rotate45back(cand[i]);
        if (test(P, ans)) {
            break;
        }
    }


    writeln(ans.x, " ", ans.y);
    //assert(false);

}

bool test(Point[] P, Point q) {
    if (q.x > 10^^9 || q.y > 10^^9) return false;
    int d = abs(P[0].x - q.x) + abs(P[0].y - q.y);
    foreach (p; P) {
        if (abs(p.x-q.x)+abs(p.y-q.y) != d) return false;
    }
    return true;
}
