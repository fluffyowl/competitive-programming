import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void solve() {
    auto s = readln.split.map!(to!long);
    auto A = s[0];
    auto B = s[1];
    if (A > B) swap(A, B);
    long ans = 2 * (A - 1);

    long hi = B + 1;
    long lo = A;
    while (hi - lo > 1) {
        long mid = (hi + lo) / 2;
        long AB = mid + A;
        bool ok = true;
        foreach (i; -5..5) {
            long a = (A + mid) / 2 + i;
            long b = AB - a;
            if (a <= A || a > mid) continue;
            if (b < A || b >= mid) continue;
            if (a * b >= A * B) ok = false;
        }
        if (ok) lo = mid;
        else hi = mid;
    }

    ans += lo - A;
    ans.writeln;
}

void main() {
    auto T = readln.chomp.to!int;
    while (T--) solve;
}
