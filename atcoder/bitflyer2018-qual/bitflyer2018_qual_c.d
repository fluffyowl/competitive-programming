import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto D = s[1].to!long;
    auto X = readln.split.map!(to!long).array;

    long ans = 0;

    int ll = 0;
    int rr = 0;
    long tmp = 0;

    foreach (i; 1..N-1) {
        while (ll < i-1 && X[i] - X[ll] > D) {
            tmp -= X[i..rr+1].assumeSorted.upperBound(X[ll]+D).length.to!long;
            ll += 1;
        }

        if (X[i] - X[i-1] > D) {
            ll = i;
        } else if (rr > i) {
            tmp += X[i+1..rr+1].assumeSorted.upperBound(X[i-1]+D).length.to!long;
        }

        rr = max(rr, i);
        while (rr+1 < N && X[rr+1] - X[i] <= D) {
            rr += 1;
            tmp += X[ll..i].assumeSorted.lowerBound(X[rr]-D).length.to!long;
        }

        ans += tmp;
    }

    ans.writeln;
}
