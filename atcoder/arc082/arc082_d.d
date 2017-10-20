import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto X = readln.chomp.to!long;
    auto K = readln.chomp.to!int + 2;
    auto RR = 0 ~ readln.split.map!(to!long).array ~ 10L^^10;
    auto R = (K-1).iota.map!(i => RR[i+1] - RR[i]).array;
    auto Q = readln.chomp.to!int;
    auto T = new long[](Q);
    auto A = new long[](Q);
    foreach (i; 0..Q) {
        auto s = readln.split.map!(to!long);
        T[i] = s[0];
        A[i] = s[1];
    }


    long[] sim0 = [0, X];
    long[] simX = [X, 0];
    long[] simN = [0, X];
    long ub = -1;
    long lb = 1L << 59;


    int q = 0;

    foreach (t; 0..K-1) {
        for ( ; q < Q && RR[t] <= T[q] && T[q] < RR[t+1]; q++) {
            debug {writeln([RR[t], T[q], RR[t+1]]);}
            debug {sim0.writeln; simX.writeln;}

            long ans;

            if (A[q] <= ub) {
                ans = max(0, sim0[0] - T[q] + RR[t]);
            } else if (A[q] >= lb) {
                ans = max(0, simX[0] - T[q] + RR[t]);
            } else if (t % 2 == 0) {
                ans = max(0, simN[0] + A[q] - T[q] + RR[t]);
            } else {
                ans = max(0, simN[0] - A[q] - T[q] + RR[t]);
            }

            if (t % 2)
                ans = X - ans;
            ans.writeln;
        }

        long d0 = min(sim0[0], R[t]);
        sim0[0] -= d0;
        sim0[1] += d0;
        swap(sim0[0], sim0[1]);

        long dX = min(simX[0], R[t]);
        simX[0] -= dX;
        simX[1] += dX;
        swap(simX[1], simX[0]);

        simN[0] -= R[t];
        simN[1] += R[t];
        swap(simN[0], simN[1]);

        if (t % 2 == 0)
            ub = max(ub, -simN[1]);
        else
            lb = min(lb, simN[1]);
    }
}
