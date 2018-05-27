import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];

    Tuple!(int, int) put(int r, int c) {
        writeln(r, " ", c);
        stdout.flush;
        s = readln.split.map!(to!int);
        return tuple(s[0], s[1]);
    }

    if (H == 1) {
        bool first = W % 2 == 0;
        writeln(first ? "First" : "Second");
        stdout.flush;
        if (!first) readln;
        for (int i = 2 + !first; i <= W; i += 2) put(1, i);
        return;
    }

    if (W == 1) {
        bool first = H % 2 == 0;
        writeln(first ? "First" : "Second");
        stdout.flush;
        if (!first) readln;
        for (int i = 2 + !first; i <= H; i += 2) put(i, 1);
        return;
    }

    bool first = (H*W-3) % 2 == 0;
    writeln(first ? "First" : "Second");
    stdout.flush;

    auto A = new bool[][](H+1, W+1);
    A[1][1] = true;
    const int[] dr = [0, 0, 1, -1];
    const int[] dc = [1, -1, 0, 0];

    if (!first) {
        auto t = readln.split.map!(to!int);
        A[t[0]][t[1]] = true;
    }


    while (true) {
        if (A[H-1][W] || A[H][W-1]) {
            put(H, W);
            return;
        }

        bool ok = false;
        foreach (i; 1..H+1) {
            foreach (j; 1..W+1) {
                if (!A[i][j]) continue;
                foreach (k; 0..4) {
                    int nr = i + dr[k];
                    int nc = j + dc[k];
                    if (nr <= 0 || nr > H || nc <= 0 || nc > W) continue;
                    if (A[nr][nc]) continue;
                    if (nr == H && nc == W-1) continue;
                    if (nr == H-1 && nc == W) continue;
                    auto t = put(nr, nc);
                    A[nr][nc] = true;
                    A[t[0]][t[1]] = true;
                    ok = true;
                    break;
                }
                if (ok) break;
            }
            if (ok) break;
        }
    }
}
