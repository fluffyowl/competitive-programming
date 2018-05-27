import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;

    int U = 100000;
    int D = -1;
    int L = 100000;
    int R = -1;

    foreach (r; 0..H) {
        foreach (c; 0..W) {
            if (A[r][c] == '#') continue;
            U = min(U, r);
            D = max(D, r);
            L = min(L, c);
            R = max(R, c);
        }
    }

    if (U == D || L == R) {
        writeln("NO");
        return;
    }

    int num = (R - L + 1) * 2 + (D - U + 1) * 2 - 4;
    if (A.map!(r => r.map!(a => a == '.').sum).sum != num) {
        writeln("NO");
        return;
    }

    bool row(int r, int c1, int c2) {
        return A[r][c1..c2+1].map!(a => a == '.').all;
    }
    
    bool col(int c, int r1, int r2) {
        return A[r1..r2+1].map!(a => a[c] == '.').all;
    }

    bool u = row(U, L, R);
    bool d = row(D, L, R);
    bool l = col(L, U, D);
    bool r = col(R, U, D);
    if (u && d && l && r) {
        writeln("YES");
        return;
    }

    foreach (i; U+1..D) {
        foreach (j; L+1..R) {
            if (d && r && row(U, j, R) && row(i, L, j) && col(L, i, D) && col(j, U, i)) {
                writeln("YES");
                return;
            }
            if (d && l && row(U, L, j) && row(i, j, R) && col(j, U, i) && col(R, i, D)) {
                writeln("YES");
                return;
            }
            if (u && l && row(i, j, R) && row(D, L, j) && col(R, U, i) && col(j, i, D)) {
                writeln("YES");
                return;
            }
            if (u && r && row(i, L, j) && row(D, j, R) && col(L, U, i) && col(j, i, D)) {
                writeln("YES");
                return;
            }
        }
    }

    writeln("NO");
}

