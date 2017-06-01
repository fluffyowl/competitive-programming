import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto X = H.iota.map!(_ => readln.chomp).array;


    auto used = new bool[][](H, W);
    int[] dr = [-1, -1, -1, 0, 0, 1, 1, 1];
    int[] dc = [-1, 0, 1, -1, 1, -1, 0, 1];
    alias Tuple!(int, "minr", int, "minc", int, "maxr", int, "maxc", int, "n") Node;
    
    Node dfs(int r, int c) {
        used[r][c] = true;
        
        Node ret;
        ret.minr = ret.maxr = r;
        ret.minc = ret.maxc = c;
        ret.n = 1;

        foreach (i; 0..8) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            if (nr < 0 || nr >= H || nc < 0 || nc >= W)
                continue;
            if (X[nr][nc] == '.' || used[nr][nc])
                continue;
            Node ret2 = dfs(nr, nc);
            ret.minr = min(ret.minr, ret2.minr);
            ret.maxr = max(ret.maxr, ret2.maxr);
            ret.minc = min(ret.minc, ret2.minc);
            ret.maxc = max(ret.maxc, ret2.maxc);
            ret.n += ret2.n;
        }

        return ret;
    }


    immutable int A = 12;
    immutable int B = 16;
    immutable int C = 11;
    int a, b, c;
    
    foreach (i; 0..H)
        foreach (j; 0..W) {
            if (X[i][j] == '.' || used[i][j])
                continue;
            Node ret = dfs(i, j);
            int scale = max(ret.maxr - ret.minr, ret.maxc - ret.minc);
            scale = (scale + 1) / 5;
            scale *= scale;
            if (ret.n == scale * A)
                a++;
            else if (ret.n == scale * B)
                b++;
            else
                c++;
        }

    writeln(a, " ", b, " ", c);
}
