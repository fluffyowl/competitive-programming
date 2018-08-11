import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!long - 1;
    auto M = readln.chomp.to!int;
    auto A = M.iota.map!(_ => readln.split.map!(to!long).array).array;
    auto B = new long[][](M, M);

    long[][] mul(const long[][] a, const long[][] b) {
        auto ret = new long[][](M, M);
        foreach (i; 0..M)
            foreach (j; 0..M)
                ret[i][j] = a[i][j];
        foreach (i; 0..M)
            foreach (j; 0..M)
                foreach (k; 0..M)
                    ret[j][k] = max(ret[j][k], a[j][i] + b[i][k]);
        return ret;
    }

    while (N) {
        if (N & 1) 
            B = mul(B, A);
        A = mul(A, A);
        N >>= 1;
    }

    B.map!(b => b.reduce!max).reduce!max.writeln;
}

