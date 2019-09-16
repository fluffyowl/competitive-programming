import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto N = readln.chomp.to!int;
    auto A = N.iota.map!(_ => readln.chomp.to!(dchar[])).array;

    int ans = 0;
    int[] rr = [0, 0, N-1, 0];
    int[] cc = [0, 0, 0, N-1];
    int[] dr = [0, 1, 0, 1];
    int[] dc = [1, 0, 1, 0];

    foreach (mask; 0..3^^4) {
        int tmp = 0;
        bool ok = true;
        auto B = A.map!(a => a.dup).array;
        foreach (i; 0..4) {
            int sr = rr[i];
            int sc = cc[i];
            int k = mask % 3;
            mask /= 3;
            if (k == 1) {
                sr += dr[i];
                sc += dc[i];
            } else if (k == 2) {
                continue;
            }
            tmp += 1;
            foreach (j; 0..N-1) {
                if (B[sr][sc] == '#') {
                    ok = false;
                    break;
                }
                B[sr][sc] = '#';
                sr += dr[i];
                sc += dc[i];
            }
        }
        if (!ok) continue;
        int row = 0;
        int col = 0;
        foreach (i; 1..N-1) {
            row += B[i][1..N-1].map!(x => x == '.').all && (B[i][0] == '.' || B[i][N-1] == '.');
        }
        foreach (j; 1..N-1) {
            col += iota(1, N-1).map!(i => A[i][j] == '.').all && (B[0][j] == '.' || B[N-1][j] == '.');
        }
        ans = max(ans, tmp + max(row, col));
    }

    ans.writeln;
}

