import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

int N, W, w1;
auto L = new int[](4);
auto V = new int[][](4);
int[][][][] mem;
int ans = 0;

void dfs(int l0, int l1, int l2, int l3, int v) {
    if (l0 > L[0] || l1 > L[1] || l2 > L[2] || l3 > L[3]) return;
    if (w1 * l0 + (w1+1) * l1 + (w1+2) * l2 + (w1+3) * l3 > W) return;
    if (mem[l0][l1][l2][l3] >= 0) return;
    ans = max(ans, v);
    mem[l0][l1][l2][l3] = v;

    if (l0 < L[0]) dfs(l0+1, l1, l2, l3, v+V[0][l0]);
    if (l1 < L[1]) dfs(l0, l1+1, l2, l3, v+V[1][l1]);
    if (l2 < L[2]) dfs(l0, l1, l2+1, l3, v+V[2][l2]);
    if (l3 < L[3]) dfs(l0, l1, l2, l3+1, v+V[3][l3]);
}

void main() {
    auto s = readln.split.map!(to!int);
    N = s[0];
    W = s[1];
    s = readln.split.map!(to!int);
    w1 = s[0];
    V[0] ~= s[1];
    foreach (i; 0..N-1) {
        s = readln.split.map!(to!int);
        V[s[0]-w1] ~= s[1];
    }

    foreach (i; 0..4) {
        V[i].sort!"a > b"();
        L[i] = V[i].length.to!int;
    }

    mem = new int[][][][](L[0]+1, L[1]+1, L[2]+1, L[3]+1);
    foreach (i; 0..L[0]+1) foreach (j; 0..L[1]+1) foreach (k; 0..L[2]+1) fill(mem[i][j][k], -1);

    dfs(0, 0, 0, 0, 0);
    ans.writeln;
}
