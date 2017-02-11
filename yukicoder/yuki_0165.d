import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


int acm2d (ref int[][] acm, int r1, int c1, int r2, int c2) {
    return acm[r2+1][c2+1] - acm[r2+1][c1] - acm[r1][c2+1] + acm[r1][c1];
}

void main() {
    alias Tuple!(int, "x", int, "y", int, "p") Point;
    int N, B;
    Point[] p;

    scanf("%d %d", &N, &B);
    p = new Point[](N);
    foreach (i; 0..N) {
        int x, y, po;
        scanf("%d %d %d", &x, &y, &po);
        p[i] = Point(x, y, po);
    }

    p.sort!"a.x < b.x"();
    int prev = p[0].x;
    p[0].x = 0;
    foreach (i; 1..N) {
        int cur = p[i].x;
        p[i].x = (p[i].x == prev) ? p[i-1].x : p[i-1].x + 1;
        prev = cur;
    }

    p.sort!"a.y < b.y"();
    prev = p[0].y;
    p[0].y = 0;
    foreach (i; 1..N) {
        int cur = p[i].y;
        p[i].y = (p[i].y == prev) ? p[i-1].y : p[i-1].y + 1;
        prev = cur;
    }


    auto acm_score = new int[][](N+1, N+1);
    auto acm_exist = new int[][](N+1, N+1);

    foreach (i; 0..N) {
        acm_score[p[i].x+1][p[i].y+1] = p[i].p;
        acm_exist[p[i].x+1][p[i].y+1] = 1;
    }


    foreach (i; 0..N+1) {
        foreach (j; 0..N) {
            acm_score[i][j+1] += acm_score[i][j];
            acm_exist[i][j+1] += acm_exist[i][j];
        }
    }

    foreach (j; 0..N+1) {
        foreach (i; 0..N) {
            acm_score[i+1][j] += acm_score[i][j];
            acm_exist[i+1][j] += acm_exist[i][j];
        }
    }

    int ans = 0;
    foreach (r1; 0..N) {
        foreach (r2; r1..N) {
            int c1, c2;
            while (c2 < N) {
                if (acm2d(acm_score, r1, c1, r2, c2) <= B) {
                    ans = max(ans, acm2d(acm_exist, r1, c1, r2, c2));
                    c2++;
                } else{
                    c1++;
                    if (c2 < c1) c2 = c1;
                }
            }
        }
    }

    ans.writeln;
}

