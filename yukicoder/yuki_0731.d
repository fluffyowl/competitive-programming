import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
immutable long INF = 1L << 59;

void main() {
    auto N = readln.chomp.to!int;
    auto X = N.iota.map!(to!real).array;
    auto Y = readln.split.map!(to!real).array;

    real E(const real[] A) {
        return A.sum / N;
    }

    real S(const real[] A, real e) {
        return sqrt(A.map!(a => (a - e) * (a - e)).sum / N);
    }

    real Ex = E(X);
    real Ey = E(Y);
    real Sx = S(X, Ex);
    real Sy = S(Y, Ey);
    real cov = E(N.iota.map!(i => (X[i] - Ex) * (Y[i] - Ey)).array);

    auto A = cov / (Sx * Sx);
    auto B = Ey - A * Ex;
    real ans = N.iota.map!(i => (Y[i] - A * X[i] - B) * (Y[i] - A * X[i] - B)).sum;

    writefln("%.9f %.9f", B, A);
    writefln("%.9f", ans);
}

