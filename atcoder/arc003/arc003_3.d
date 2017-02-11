import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

int H, W, Sr, Sc, Gr, Gc;
int[][] B;
int[4] dr = [0, 0, 1, -1];
int[4] dc = [1, -1, 0, 0];
real[] pw99;
 
 
bool bfs(real limit) {
    auto used = new bool[][](H, W);
    DList!int qr;
    DList!int qc;
    DList!int qd;
    qr.insert(Sr);
    qc.insert(Sc);
    qd.insert(1);
    used[Sr][Sc] = true;
 
    while (!qr.empty) {
        auto nr = qr.front;
        auto nc = qc.front;
        auto nd = qd.front;
        qr.removeFront;
        qc.removeFront;
        qd.removeFront;
        if (nr == Gr && nc == Gc)
            return true;
    
        foreach (i; 0..4) {
            auto mr = nr + dr[i];
            auto mc = nc + dc[i];
            if (mr >= 0 && mr < H && mc >= 0 && mc < W
                && !used[mr][mc] && B[mr][mc] != '#'-'0') {
                used[mr][mc] = true;
                if (B[mr][mc] * pw99[nd] >= limit) {
                    qr.insert(mr);
                    qc.insert(mc);
                    qd.insert(nd+1);
                }
            }
        }
        
    }
    
    return false;
}
 
void main() {
    auto input = readln.split.map!(to!int).array;
    H = input[0];
    W = input[1];
    B = iota(H).map!(_ => readln.chomp.map!(c => (c.to!int-'0'.to!int)).array).array;

    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (B[i][j] == 's'-'0') {Sr = i; Sc = j;}
            if (B[i][j] == 'g'-'0') {Gr = i; Gc = j;}
        }
    }

    int p_max = 300000;
    pw99 = new real[](p_max);
    pw99[0] = 1;
    foreach (i; 0..p_max-1)
        pw99[i+1] = pw99[i] * 0.99L;

 
    real high = 9.00;
    real low = 0.0;
 
    foreach (i; 0..50) {
        auto mid = (high + low) / 2.0;
        if (bfs(mid))
            low = mid;
        else
            high = mid;
    }
    
    if (!bfs(-1))
        writeln(-1);
    else
        writefln("%.9f", low);

}
