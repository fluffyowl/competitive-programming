import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


int[][] ms_odd(int n) {
    auto ans = new int[][](n, n);
    int r = 0;
    int c = n / 2;
    foreach (i; 1..n*n+1) {
        ans[r][c] = i;
        int nr = r == 0 ? n - 1 : r-1;
        int nc = (c+1) % n;
        if (ans[nr][nc] > 0) {
            nr = (r+1) % n;
            nc = c;
        }
        r = nr;
        c = nc;
    }
    return ans;
}

int[][] ms_4n(int n) {
    auto ans = new int[][](n, n);

    int i = 1;
    foreach (r; 0..n) {
        foreach (c; 0..n) {
            if ((r % 4 == 0 || r % 4 == 3) && (c % 4 == 0 || c % 4 == 3))
                ans[r][c] = i;
            if ((r % 4 == 1 || r % 4 == 2) && (c % 4 == 1 || c % 4 == 2))
                ans[r][c] = i;
            i++;
        }
    }

    i = 1;
    foreach (r; iota(n-1, -1, -1)) {
        foreach (c; iota(n-1, -1, -1)) {
            if (ans[r][c] == 0)
                ans[r][c] = i;
            i++;
        }
    }
    return ans;
}

int[][] ms_4n2(int n) {
    auto ans = new int[][](n, n);
    auto base = ms_odd(n/2);

    foreach (r; 0..n/2)
        foreach (c; 0..n/2)
            base[r][c] = (base[r][c]-1) * 4;

    auto LUX = new char[][](n/2, n/2);
    foreach (r; 0..n/2)
        foreach (c; 0..n/2) {
            if (r <= n/4)
                LUX[r][c] = 'L';
            else if (r == n/4+1)
                LUX[r][c] = 'U';
            else
                LUX[r][c] = 'X';
        }
    swap(LUX[n/4][n/4], LUX[n/4+1][n/4]);

    foreach (r; 0..n/2) {
        foreach (c; 0..n/2) {
            auto p = new int[][](2, 2);
            if      (LUX[r][c] == 'L') p = [[4, 1], [2, 3]];
            else if (LUX[r][c] == 'U') p = [[1, 4], [2, 3]];
            else if (LUX[r][c] == 'X') p = [[1, 4], [3, 2]];
            foreach (dr; 0..2) {
                foreach (dc; 0..2) {
                    ans[r*2+dr][c*2+dc] = p[dr][dc] + base[r][c];
                }
            }

        }
    }

    return ans;
}

void main() {
    auto N = readln.chomp.to!int;

    int[][] ans;

    if (N % 2 == 1)
        ans = ms_odd(N);
    else if (N % 4 == 0)
        ans = ms_4n(N);
    else
        ans = ms_4n2(N);

    ans.each!(a => a.map!(to!string).join(" ").writeln);


}

