import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

int N, M, x, y;
int[][] adj;
bool[][] reachable;
long[] mem;


long dp(int b) {
    if (b == 0)
        return 1;
    if (mem[b] >= 0)
        return mem[b];

    mem[b] = 0;

    foreach (i; 0..N) {
        if (b & (1 << i)) {
            bool flag = true;
            foreach (j; 0..N) {
                if ((i != j) && (b & (1 << j)) && (reachable[i][j])) {
                    flag = false;
                    break;
                }
            }
            if (flag) mem[b] += dp(b ^ (1 << i));
        }

    }

    return mem[b];

}

void main() {

    scanf("%d %d", &N, &M);
    adj = new int[][](N);
    foreach (i; 0..M) {
        scanf("%d %d", &x, &y);
        adj[x-1] ~= y-1;
    }

    reachable = new bool[][](N, N);

    foreach (i; 0..N) {
        DList!int q;
        q.insert(i);
        while (!(q.empty)) {
            auto n = q.front;
            q.removeFront;
            if (n != i) reachable[i][n] = true;
            foreach (m; adj[n])
                q.insert(m);
        }
    }


    mem = new long[](1<<N);
    foreach (i ; 0..(1<<N))
        mem[i] = -1;

    dp((1<<N)-1).writeln;

}
