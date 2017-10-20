import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto N = readln.chomp.to!int;
    auto M = 2 * N - 1;
    auto A = readln.split.map!(to!int).array;

    int hi = M + 1;
    int lo = 0;
    while (hi - lo > 1) {
        int mid = (hi + lo) / 2;
        auto B = A.map!(a => a >= mid).array;
        int a = B[N-2], b = B[N-1], c = B[N];
        if ((a & b) || (b & c)) {
            lo = mid;
        } else if ((!a & !b) || (!b & !c)) {
            hi = mid;
        } else {
            bool ok = false;
            for (int l = N - 3, r = N + 1; l >= 0; l--, r++) {
                if (B[l] == B[l+1]) {
                    if (B[l]) lo = mid;
                    else hi = mid;
                    ok = true;
                    break;
                } else if (B[r] == B[r-1]) {
                    if (B[r]) lo = mid;
                    else hi = mid;
                    ok = true;
                    break;
                }
            }
            if (!ok) {
                bool hoge = B[N-1];
                if (M / 2 % 2) hoge ^= 1;
                if (hoge) lo = mid;
                else hi = mid;
            }
        }
    }

    lo.writeln;
}
