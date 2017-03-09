import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

int[int][int] up;
int[int][int] down;
int[int][int] right;
int[int][int] left;

void main() {
    auto K = readln.chomp.to!int;
    auto S = readln.chomp;

    int x, y;
    up[0][0] = 1;
    down[0][0] = -1;
    right[0][0] = 1;
    left[0][0] = -1;

    foreach (i; 0..K) {
        int nx = x;
        int ny = y;
    
        if (S[i] == 'U')      ny = up[x][y];
        else if (S[i] == 'D') ny = down[x][y];
        else if (S[i] == 'R') nx = right[x][y];
        else if (S[i] == 'L') nx = left[x][y];
        else assert(true);

        int u = ny + 1;
        int d = ny - 1;
        int r = nx + 1;
        int l = nx - 1;
        int nu = (nx in up && u in up[nx])      ? up[nx][u]    : ny + 1;
        int nd = (nx in up && d in down[nx])    ? down[nx][d]  : ny - 1;
        int nr = (r in right && ny in right[r]) ? right[r][ny] : nx + 1;
        int nl = (l in left && ny in left[l])   ? left[l][ny]  : nx - 1;

        up[nx][nd+1] = nu;
        down[nx][nu-1] = nd;
        right[nl+1][ny] = nr;
        left[nr-1][ny] = nl;

        up[nx][ny] = nu;
        down[nx][ny] = nd;
        right[nx][ny] = nr;
        left[nx][ny] = nl;
        
        x = nx;
        y = ny;
    }

    writeln(x, " ", y);
}
