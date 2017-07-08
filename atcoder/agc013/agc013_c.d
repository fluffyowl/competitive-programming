import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;
 
void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0].to!int;
    auto L = s[1];
    auto T = s[2];
    auto A = new Tuple!(int, long, long)[](N);
    foreach (i; 0..N) {
        s = readln.split.map!(to!long);
        A[i] = tuple(i, s[0], s[1]);
    }
 
    long conflict = 0;
    foreach (i; 0..N) {
        if (A[0][2] == 1 && A[i][2] == 2) {
            long t = 2 * T - A[i][1] + A[0][1];
            if (t >= 0)
                conflict += t / L + 1;
        } else if (A[0][2] == 2 && A[i][2] == 1) {
            long t = 2 * T - (L - A[i][1] + A[0][1]);
            if (t >= 0)
                conflict -= t / L + 1;
        }
        conflict = (conflict % N + N) % N;
    }
 
    auto B = new Tuple!(int, long)[](N);
    foreach (i; 0..N) {
        if (A[i][2] == 1) B[i] = tuple(i, (A[i][1] + T) % L);
        else B[i] = tuple(i, ((A[i][1] - T) % L + L) % L);
    }
    if (A[0][2] == 1) B.sort!"a[1] == b[1] ? a[0] > b[0] : a[1] < b[1]"();
    else B.sort!"a[1] == b[1] ? a[0] < b[0] : a[1] < b[1]"();

    debug B.writeln;
 
    foreach (i; 0..N) {
        if (B[i][0] == 0) {
            foreach (j; 0..N) B[(i + j) % N][0] = (conflict + j) % N;
            break;
        }
    }
 
    debug B.writeln;
    B.sort!"a[0] < b[0]"();
    foreach (b; B) b[1].writeln;
 
}
