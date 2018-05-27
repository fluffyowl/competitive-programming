import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto R = s[0].to!real;
    auto N = s[1];
    auto M = s[2];

    auto center = N / 2.0L;
    auto A = new Tuple!(real, int)[](N-1);

    foreach (i; 1..N) {
        real h = R * abs(center - i) / center;
        real k = sqrt(R * R - h * h);
        A[i-1] = tuple(k*2, i);
    }

    A.sort!"a[0] > b[0]";
    auto used = new bool[](N-1);
    real ans = 0;

    foreach (i; 0..N-1) {
        if (used[i]) continue;
        used[i] = true;
        ans += A[i][0];
        foreach (j; i+1..N-1) {
            if (used[j] || abs(A[i][1] - A[j][1]) < M) continue;
            used[j] = true;
            break;
        }
    }

    writefln("%.09f", ans);
}
