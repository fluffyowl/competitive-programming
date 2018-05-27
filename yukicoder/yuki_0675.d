import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    alias Point = Tuple!(long, "x", long, "y");

    auto s = readln.split.map!(to!long);
    auto N = s[0].to!int;
    auto S = Point(s[1], s[2]);
    auto Q = new Tuple!(long, long)[](N);
    foreach (i; 0..N) {
        s = readln.split.map!(to!long);
        long x = s[0] == 3 ? 0 : s[1];
        Q[i] = tuple(s[0], x);
    }

    Point[] ans;

    auto M = new long[][](3, 3);
    foreach (i; 0..3) M[i][i] = 1;

    auto move = new long[][](3, 3);
    foreach (i; 0..3) move[i][i] = 1;

    auto rot = new long[][](3, 3);
    rot[0][1] = 1;
    rot[1][0] = -1;
    rot[2][2] = 1;

    foreach_reverse (q; Q) {
        if (q[0] == 1) {
            move[0][2] = q[1];
            M = matmul(3, M, move);
            move[0][2] = 0;
        } else if (q[0] == 2) {
            move[1][2] = q[1];
            M = matmul(3, M, move);
            move[1][2] = 0;
        } else {
            M = matmul(3, M, rot);
        }
        auto x = M[0][0] * S.x + M[0][1] * S.y + M[0][2];
        auto y = M[1][0] * S.x + M[1][1] * S.y + M[1][2];
        ans ~= Point(x, y);
    }

    foreach_reverse (a; ans) {
        writeln(a.x, " ", a.y);
    }
}

long[][] matmul(int N, long[][] m1, long[][] m2) {
    auto ret = new long[][](N, N);
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            ret[i][j] = 0;
            foreach (k; 0..N) {
                ret[i][j] += m1[i][k] * m2[k][j];
            }
        }
    }
    return ret;
}

