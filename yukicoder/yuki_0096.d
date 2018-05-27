import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto P = N.iota.map!(_ => readln.split.map!(to!int)).map!(a => Point(a[0], a[1])).array;

    if (N == 0) {
        writeln(1);
        return;
    }

    Tuple!(int, int)[][int] X;
    foreach (i, p; P.enumerate) {
        X[p.x] ~= tuple(p.y, i.to!int);
    }
    foreach (k; X.keys) X[k].sort();

    auto uf = new UnionFind(N);
    foreach (i, p; P.enumerate) {
        foreach (dx; -10..11) {
            int nx = p.x + dx;
            if (nx !in X) continue;
            int j = X[nx].assumeSorted.lowerBound(tuple(p.y, 0)).length.to!int;
            for (int k = j; k < X[nx].length; ++k) {
                int ny = X[nx][k][0];
                if (dx * dx + (ny - p.y) * (ny - p.y) > 100) break;
                if (nx != p.x || ny != p.y) uf.unite(i.to!int, X[nx][k][1]);
            }
            for (int k = min(j, X[nx].length.to!int-1); k >= 0; --k) {
                int ny = X[nx][k][0];
                if (dx * dx + (ny - p.y) * (ny - p.y) > 100) break;
                if (nx != p.x || ny != p.y) uf.unite(i.to!int, X[nx][k][1]);            
            }
        }
    }

    int farest = 0;
    foreach (i; 0..N) {
        if (uf.groups[i].empty) continue;
        auto ch = convex_hull(uf.groups[i].map!(i => P[i]).array);
        foreach (j; 0..ch.length) {
            foreach (k; j+1..ch.length) {
                farest = max(farest, dist2(ch[j], ch[k]));
            }
        }
    }

    writefln("%.9f", sqrt(farest * 1.0L) + 2);
}

struct Point {
    int x;
    int y;
}

Point[] convex_hull(Point[] points) {
    int N = points.length.to!int;
    points.sort!((a, b) => a.x == b.x ? a.y < b.y : a.x < b.x);
    Point[] ch1, ch2;
    foreach (i; 0..N) {
        while (ch1.length >= 2 && rot(ch1[$-2], ch1[$-1], points[i]) <= 0) ch1.popBack;
        ch1 ~= points[i];
    }
    foreach_reverse (i; 0..N) {
        while (ch2.length >= 2 && rot(ch2[$-2], ch2[$-1], points[i]) <= 0) ch2.popBack;
        ch2 ~= points[i];
    }

    auto ch = ch1 ~ ch2;
    return ch.sort!((a, b) => a.x == b.x ? a.y < b.y : a.x < b.x).uniq.array;
}

int rot(Point a, Point b, Point c) {
    // a -> b -> c の向き
    // 正なら左、負なら右、0なら同一直線状
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
}

int dist2(Point a, Point b) {
    return (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y);
}

class UnionFind {
    int N;
    int[] table;
    int[][] groups;

    this(int n) {
        N = n;
        table = new int[](N);
        fill(table, -1);
        groups = new int[][](N);
        foreach (i; 0..N) groups[i] = [i];
    }

    int find(int x) {
        return table[x] < 0 ? x : (table[x] = find(table[x]));
    }

    void unite(int x, int y) {
        x = find(x);
        y = find(y);
        if (x == y) return;
        if (table[x] > table[y]) swap(x, y);
        table[x] += table[y];
        table[y] = x;
        groups[x] ~= groups[y];
        groups[y] = [];
    }
}


