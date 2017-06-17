import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;//, core.stdc.stdio;

int sum2d(int[][] A, int r1, int c1, int r2, int c2) {
    return A[r2+1][c2+1] - A[r2+1][c1] - A[r1][c2+1] + A[r1][c1];
}

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto Q = s[2];
    auto B = H.iota.map!(_ => readln.chomp).array;

    auto blue = new int[][](H+1, W+1);
    foreach (i; 0..H) foreach (j; 0..W) blue[i+1][j+1] = B[i][j] == '1' ? 1 : 0;
    foreach (i; 0..H) foreach (j; 0..W) blue[i+1][j+1] += blue[i+1][j];
    foreach (j; 0..W) foreach (i; 0..H) blue[i+1][j+1] += blue[i][j+1];

    auto tate = new int[][](H+1, 2*W);
    foreach (i; 0..H) foreach (j; 0..W-1) tate[i+1][2*j+2] = (B[i][j] == '1' && B[i][j+1] == '1') ? 1 : 0;
    foreach (i; 0..H) foreach (j; 0..2*W-1) tate[i+1][j+1] += tate[i+1][j];
    foreach (j; 0..2*W-1) foreach (i; 0..H) tate[i+1][j+1] += tate[i][j+1];
    
    auto yoko = new int[][](2*H, W+1);
    foreach (i; 0..H-1) foreach (j; 0..W) yoko[2*i+2][j+1] = (B[i][j] == '1' && B[i+1][j] == '1') ? 1 : 0;
    foreach (i; 0..2*H-1) foreach (j; 0..W) yoko[i+1][j+1] += yoko[i+1][j];
    foreach (j; 0..W) foreach (i; 0..2*H-1) yoko[i+1][j+1] += yoko[i][j+1];


    while (Q--) {
        s = readln.split.map!(to!int);
        int r1 = s[0] - 1, c1 = s[1] - 1, r2 = s[2] - 1, c2 = s[3] - 1;
        int a = sum2d(blue, r1, c1, r2, c2);
        int b = sum2d(tate, r1, c1*2, r2, c2*2);
        int c = sum2d(yoko, r1*2, c1, r2*2, c2);
        writeln(a - b - c);
    }

}
