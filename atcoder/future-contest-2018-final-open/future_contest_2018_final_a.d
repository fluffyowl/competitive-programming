import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable int N = 50;
int T = 1000;
int M = 100;
int W = 100;

struct Point {
    int r, c;
    string toString() const pure @safe {
        int nr = max(0, r); nr = min(N-1, nr);
        int nc = max(0, c); nc = min(N-1, nc);
        return to!string(nc + 1) ~ " " ~ to!string(nr + 1);
    }
    bool out_of() const pure @safe {
        return r < 0 || r >= N || c < 0 || c >= N;
    }
}

void destroy(Point p1, Point p2) {
    if (p1.r >= p2.r && p1.c >= p2.c) swap(p1, p2);
    T--;
    writeln("destroy ", p1, " ", p2);
}

void plant(Point p) {
    T--;
    writeln("plant ", p);
}

void harvest(Point p1, Point p2) {
    if (p1.r >= p2.r && p1.c >= p2.c) swap(p1, p2);
    T--;
    writeln("harvest ", p1, " ", p2);
}

void growup(int n) {
    T--;
    M -= n * n;
    W += n;
    writeln("growup ", n);
}

void work() {
    T--;
    M++;
    writeln("work");
}

void main() {
    auto A = N.iota.map!(_ => readln.chomp).array;

    Point warp;
    foreach (i; 0..N) foreach (j; 0..N) if (A[i][j] == 'W') warp.r = i, warp.c = j;


    outer: foreach (i; warp.r-5..warp.r+5) {
        foreach (j; warp.c-5..warp.c+5) {
            if (i < 0 || i >= N || j < 0 || j >= N || A[i][j] != '.') continue;
            plant(Point(i, j));
            break outer;
        }
    }

    foreach (_; 0..55) growup(1);
    foreach (_; 0..55) work();

    int[] dr = [1, -1, 0, 0];
    int[] dc = [0, 0, 1, -1];
    int[] broken_cnt = [0, 0, 0, 0];
    int[] tsukammo_cnt = [0, 0, 0, 0];
    int[] planted = [0, 0, 0, 0];
    int[] planted_turn = [0, 0, 0, 0];
    int dir = 0;
    int score = 0;

    outer2: while (T > 0) {
        foreach (i; 0..4) if (planted[i] > 0 && planted[i] < broken_cnt[i]) planted[i] += 1;
        foreach (i; 0..4) if (planted[i] > 0) planted_turn[i] += 1;
        foreach (i; 0..4) if (planted[i]) tsukammo_cnt[i] += planted[i];

        Point frontier = Point(warp.r + dr[dir] * (broken_cnt[dir] + 1),
                               warp.c + dc[dir] * (broken_cnt[dir] + 1));
;
        while (frontier.out_of) {
            dir = (dir + 1) % 4;
            frontier = Point(warp.r + dr[dir] * (broken_cnt[dir] + 1),
                             warp.c + dc[dir] * (broken_cnt[dir] + 1));
        }

        int broken_max = broken_cnt.reduce!max + 1;
        int destroy_cost = broken_cnt[dir] * 10 + 50;
        int harvest_cost = broken_max * (broken_max + 1) / 2 * 10 - 10 * broken_max;

        foreach (i; 0..4) {
            if ((planted_turn[i] >= 50) || (T <= 4 && tsukammo_cnt[i] > 0)) {
                int nr = warp.r + dr[i] * broken_cnt[i];
                int nc = warp.c + dc[i] * broken_cnt[i];
                harvest(Point(nr, nc), warp);
                M += tsukammo_cnt[i];
                score += tsukammo_cnt[i];
                tsukammo_cnt[i] = 0;
                planted[i] = 0;
                planted_turn[i] = 0;
                //writeln([1000-T, W, M, score]);
                continue outer2;
            }
        }

        foreach (i; 0..4) {
            if (planted[i] == 0 && broken_cnt[i] > 0) {
                plant(Point(warp.r + dr[i], warp.c + dc[i]));
                planted[i] = 1;
                tsukammo_cnt[i] = 1;
                continue outer2;
            }
        }

        if (M >= destroy_cost && W >= harvest_cost) {
            destroy(frontier, frontier);
            broken_cnt[dir] += 1;
            M -= destroy_cost;
            dir = (dir + 1) % 4;
        } else if (M >= destroy_cost) {
            growup(5);
        } else {
            work();
        }

        //writeln([1000-T, W, M, score]);
    }
}
