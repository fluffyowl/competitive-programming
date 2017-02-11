import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    int N, X;
    int[] W;
    scanf("%d %d", &N, &X);
    W = new int[](N);
    foreach (i; 0..N)
        scanf("%d", &W[i]);

    auto m1 = 1 << (N/2);
    auto n1 = new int[](m1);

    foreach (i; 0..m1) {
        foreach (j; 0..N/2) {
            if (i & (1 << j)) {
                n1[i] += W[j];
            }
        }
    }

    auto m2 = 1 << (N/2 + N%2);
    auto n2 = new int[](m2);

    foreach (i; 0..m2) {
        foreach (j; 0..N/2+N%2) {
            if (i & (1 << j)) {
                n2[i] += W[j+N/2];
            }
        }
    }

    n1.sort();
    n2.sort();
    auto n3 = assumeSorted(n2);

    long ans = 0;
    foreach (i; 0..m1) {
        long tmp = 0;
        auto p1 = n3.lowerBound(X-n1[i]).length;
        auto p2 = n3.lowerBound(X-n1[i]+1).length;
        ans += p2 - p1;
    }

    ans.writeln;
}
