import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


alias Tuple!(int, "x1", int, "y1", int, "x2", int, "y2") Rect;
int W, H, N;
int[] X, Y;
long[Rect] mem;


long dp(Rect r) {
    if (r in mem) return mem[r];
    if (r.x1 > r.x2 || r.y1 > r.y2) return 0;

    mem[r] = 0;
    foreach (i; 0..N) {
        if (X[i] >= r.x1 && X[i] <= r.x2 && Y[i] >= r.y1 && Y[i] <= r.y2) {
            long ret =
                dp(Rect(r.x1, r.y1, X[i]-1, Y[i]-1)) +
                dp(Rect(X[i]+1, r.y1, r.x2, Y[i]-1)) +
                dp(Rect(r.x1, Y[i]+1, X[i]-1, r.y2)) +
                dp(Rect(X[i]+1, Y[i]+1, r.x2, r.y2)) +
                r.y2 - r.y1 + r.x2 - r.x1 + 1;
            mem[r] = max(mem[r], ret);
        }
    }
    return mem[r];
}


void main() {
    scanf("%d %d", &W, &H);
    scanf("%d", &N);
    X = new int[](N);
    Y = new int[](N);
    foreach (i; 0..N) scanf("%d %d", &X[i], &Y[i]);

    dp(Rect(1, 1, W, H)).writeln;
}
