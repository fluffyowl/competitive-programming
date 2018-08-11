import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto B = new long[](N+1);
    foreach (i; 0..N) B[i+1] = B[i] + A[i];

    int a = 0;
    int b = 2;
    long sa1 = A[0];
    long sa2 = A[1];
    long sb1 = A[2];
    long sb2 = B[N] - B[3];
    long ans = 1L << 59;
    
    foreach (i; 2..N-1) {
        while (a < i-1 && sa1 + A[a+1] <= sa2 - A[a+1]) sa1 += A[a+1], sa2 -= A[a+1], a += 1;
        while (b < N-1 && sb1 + A[b+1] <= sb2 - A[b+1]) sb1 += A[b+1], sb2 -= A[b+1], b += 1;
        Tuple!(long, long)[] x = [tuple(sa1, sa2)];
        Tuple!(long, long)[] y = [tuple(sb1, sb2)];
        if (a < i - 1) x ~= tuple(sa1 + A[a+1], sa2 - A[a+1]);
        if (b < N - 1) y ~= tuple(sb1 + A[b+1], sb2 - A[b+1]);
        foreach (u; x) foreach (v; y) ans = min(ans, max(u[0], u[1], v[0], v[1]) - min(u[0], u[1], v[0], v[1]));

        sa2 += A[i];
        sb1 -= A[i];
        if (b == i) {
            b = i + 1;
            sb1 = A[i+1];
            sb2 = B[N] - B[i+2];
        }
    }

    ans.writeln;
}
