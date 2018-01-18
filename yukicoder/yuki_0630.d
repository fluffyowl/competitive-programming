import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;

void main() {
    auto s = readln.split.map!(to!int).array;
    auto N = s[0];
    auto M = s[1];

    if (M < N-1 || M > (N.to!long/2)*(N.to!long/2+N%2)) {
        writeln("NO");
        return;
    }

    writeln("YES");

    int[] A;
    foreach (i; 1..N+1) {
        if (i%2 == 1) {
            A ~= i/2+1;
        } else {
            A ~= i/2+N/2+N%2;
        }
    }

    A.map!(to!string).join(" ").writeln;

    foreach (i; 0..N-1) writeln(i+1, " ", i+2);
    int cnt = N-1;

    for (int i = 1; i <= N && cnt < M; i += 2) {
        for (int j = 2; j <= N && cnt < M; j += 2) {
            if (j == i+1 || j == i-1) continue;
            cnt++;
            writeln(i, " ", j);
        }
    }
}

