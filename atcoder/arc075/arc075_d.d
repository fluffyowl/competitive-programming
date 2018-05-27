import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

long[] A;
long[] B;
Tuple!(long, long)[] X;
Tuple!(long, long)[] Y;


void main() {
    auto D = readln.chomp.to!long;

    A = new long[](10);
    B = new long[](10);
    X = new Tuple!(long, long)[](10);
    Y = new Tuple!(long, long)[](10);

    foreach (i; 0..10) {
        foreach (j; 0..10) {
            if (i >= j) {
                A[i-j] += 1;
                X[i-j] = tuple(i.to!long, j.to!long);
            } else {
                B[i-j+10] += 1;
                Y[i-j+10] = tuple(i.to!long, j.to!long);
            }
        }
    }

    long ans = 0;

    foreach (i; D.to!string.length.to!int..19) {
        ans += solve(D, i);
    }

    ans.writeln;
}

long solve(long D, int N) {
    int M = N/2 + N%2;

    long ans = 0;

    int[] DD;
    long d = D;
    for (int i = 0; i < N; ++i, d/=10) {
        DD ~= (d % 10).to!int;
    }

    foreach (mask; 0..(1 << M)) {
        long tmp = 1;
        long[] tmp1;
        long[] tmp2;
        bool carry = false;
        foreach (i; 0..M) {
            if (mask & (1 << i)) {
                if (carry) {
                    tmp *= A[(DD[i]+1)%10];
                    tmp1 ~= X[(DD[i]+1)%10][0];
                    tmp2 ~= X[(DD[i]+1)%10][1];
                    carry = DD[i] == 9;
                } else if (i == 0) {
                    tmp *= A[DD[i]] - 1;
                    tmp1 ~= X[DD[i]][0];
                    tmp2 ~= X[DD[i]][1];
                } else {
                    tmp *= A[DD[i]];
                    tmp1 ~= X[DD[i]][0];
                    tmp2 ~= X[DD[i]][1];
                    carry = false;
                }
            } else {
                if (carry && DD[i] == 9) {
                    tmp = 0;
                    break;
                } else if (carry) {
                    tmp *= B[DD[i]+1];
                    tmp1 ~= Y[DD[i]+1][0];
                    tmp2 ~= Y[DD[i]+1][1];
                } else if (i == 0) {
                    tmp *= B[DD[i]] - 1;
                    tmp1 ~= Y[DD[i]][0];
                    tmp2 ~= Y[DD[i]][1];
                    carry = true;
                } else {
                    tmp *= B[DD[i]];
                    tmp1 ~= Y[DD[i]][0];
                    tmp2 ~= Y[DD[i]][1];
                    carry = true;
                }
            }
        }

        if (tmp == 0) continue;
        if (N % 2 == 1) tmp1.popBack;
        long e = 0;
        long f = 0;
        foreach (i; tmp1) e *= 10, e += i;
        foreach_reverse (i; tmp2) e *= 10, e += i;
        foreach (i; tmp2) f *= 10, f += i;
        foreach_reverse (i; tmp1) f *= 10, f += i;
        if (f - e != D) tmp = 0;
        ans += tmp;
    }

    return ans;
}
