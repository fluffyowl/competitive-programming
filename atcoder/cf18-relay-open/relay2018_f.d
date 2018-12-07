import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long INF = 1L << 59;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    auto T = N.iota.map!(_ => readln.chomp.to!long).array;

    double ans = 0;
    double L = 1.0L / K;

    auto P = new double[][](N+1, K+1);
    foreach (i; 0..N+1) fill(P[i], 0);
    P[0][0] = 1;

    auto E = new double[](K);
    foreach (i; 0..K) {
        E[i] = 0;
        foreach (j; i..K*2) {
            if (j < K) {
                E[i] += 1.0L * (j - i) * L;
            } else {
                E[i] += 1.0L * (j - i) * i * L * L;
            }
        }
    }

    foreach (i; 0..N) {
        foreach (j; 0..K) {
            ans += P[i][j] * (E[j] + T[i]);
            long l = (j + T[i]) % K;
            long r = (K - 1 + T[i]) % K;
            if (l <= r) {
                P[i+1][l] += P[i][j] * L;
                P[i+1][r+1] -= P[i][j] * L;
            } else {
                P[i+1][l] += P[i][j] * L;
                P[i+1][K] -= P[i][j] * L;
                P[i+1][0] += P[i][j] * L;
                P[i+1][r+1] -= P[i][j] * L;
            }
            P[i+1][0] += P[i][j] * j * L * L;
            P[i+1][K] -= P[i][j] * j * L * L;
        }
        foreach (j; 0..K) {
            P[i+1][j+1] += P[i+1][j];
        }
    }

    writefln("%.15f", ans);
}
