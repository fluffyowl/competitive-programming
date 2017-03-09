import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;
import std.datetime;

int N, M, K, C;
bool[][] adj;
int[][] c2;
real p;

bool playout() {
    auto order = new int[](N);
    foreach (i; 0..N) order[i] = i;

    foreach (k; 0..K) {
        int i = uniform(0, C);
        swap(order[c2[i][0]], order[c2[i][1]]);
    }

    foreach (i; 0..N) {
        if (!adj[order[i]][order[(i+1)%N]]) return false;
    }

    return true;
}


void main() {
    auto stattime = Clock.currTime();
    scanf("%d %d %d", &N, &M, &K);
    adj = new bool[][](N, N);
    foreach (i; 0..N) fill(adj[i], true);
    foreach (i; 0..M) {
        int a, b;
        scanf("%d %d", &a, &b);
        adj[a][b] = false;
        adj[b][a] = false;
    }

    C = N * (N-1) / 2;
    c2 = new int[][](C, 2);
    int c = 0;
    foreach (i; 0..N) {
        foreach (j; i+1..N) {
            c2[c] = [i, j];
            c++;
        }
    }
    
    int a = 0;
    int b = 0;
    while ((Clock.currTime - stattime).total!"msecs" < dur!"msecs"(9950).total!"msecs") {
        if (playout) a += 1;
        b += 1;
    }

    writefln("%.10f", 1.0L * a / b);
}
