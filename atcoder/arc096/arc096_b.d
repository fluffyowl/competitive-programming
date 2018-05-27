import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0].to!int;
    auto C = s[1];
    auto X = new long[](N);
    auto V = new long[](N);
    foreach (i; 0..N) {
        s = readln.split.map!(to!long);
        X[i] = s[0];
        V[i] = s[1];
    }

    auto dp1 = new long[](N);
    auto dp2 = new long[](N);

    dp1[0] = V[0] - X[0];
    dp2[N-1] = V[N-1] - (-X[N-1] + C);

    foreach (i; 1..N) {
        dp1[i] = dp1[i-1] + V[i] - (X[i] - X[i-1]);
    }

    foreach_reverse (i; 0..N-1) {
        dp2[i] = dp2[i+1] + V[i] - (X[i+1] - X[i]);
    }

    long ans = max(0, dp1.reduce!max, dp2.reduce!max);


    auto dpdp1 = new long[](N);
    auto dpdp2 = new long[](N);
    dpdp1[0] = dp1[0];
    dpdp2[N-1] = dp2[N-1];
    foreach (i; 1..N) dpdp1[i] = max(dp1[i], dpdp1[i-1]);
    foreach_reverse (i; 0..N-1) dpdp2[i] = max(dp2[i], dpdp2[i+1]);


    foreach (i; 0..N-1) {
        long tmp = dp1[i] - X[i] + dpdp2[i+1];
        ans = max(ans, tmp);
    }
    foreach_reverse (i; 1..N) {
        long tmp = dp2[i] - (-X[i]+C) + dpdp1[i-1];
        ans = max(ans, tmp);
    }

    ans.writeln;
}
