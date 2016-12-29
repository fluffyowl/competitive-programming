import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


alias Tuple!(int, "e", int, "c") edge;
int N, M, a, b, c;
int[] earliest, latest;
edge[][] adj;
edge[][] inv;

int rec_back(int n) {
    if (earliest[n] > -1)
        return earliest[n];
    earliest[n] = inv[n].map!(to => rec_back(to.e)+to.c).reduce!(max);
    return earliest[n];
}

int rec_forward(int n) {
    if (latest[n] > -1)
        return latest[n];
    latest[n] = adj[n].map!(to => rec_forward(to.e)-to.c).reduce!(min);
    return latest[n];
}

void main() {
    scanf("%d %d", &N, &M);

    adj = new edge[][](N);
    inv = new edge[][](N);
    foreach (i; 0..M) {
        scanf("%d %d %d", &a, &b, &c);
        adj[a] ~= edge(b, c);
        inv[b] ~= edge(a, c);
    }

    earliest = new int[](N);
    earliest[0] = 0;
    foreach (i; 1..N) earliest[i] = -1;
    rec_back(N-1);

    latest = new int[](N);
    latest[N-1] = earliest[N-1];
    foreach (i; 0..N-1) latest[i] = -1;
    rec_forward(0);

    int ans = N.iota.map!(n => earliest[n] < latest[n]).sum;
    writefln("%d %d/%d", latest[N-1], ans, N);
}

