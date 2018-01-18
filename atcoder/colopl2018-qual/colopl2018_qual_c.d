import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;


void main() {
    auto s = readln.split.map!(to!long);
    auto A = s[0];
    auto B = s[1];

    long[] odd;
    long[] even;

    foreach (i; A..B+1) {
        if (i % 2 == 0) even ~= i;
        else odd ~= i;
    }

    int M = odd.length.to!int;
    long ans = 0;

    foreach (mask; 0..(1 << M)) {
        long[] hoge;
        foreach (i; 0..M) {
            if (mask & (1 << i)) {
                hoge ~= odd[i];
            }
        }

        bool ok = true;
        foreach (i; 0..hoge.length) {
            foreach (j; i+1..hoge.length) {
                if (gcd(hoge[i], hoge[j]) != 1) {
                    ok = false;
                    break;
                }
            }
        }

        if (!ok) {
            continue;
        }

        ans += 1;

        foreach (i; even) {
            if (hoge.length == 0 || hoge.map!(h => gcd(h, i) == 1).all) {
                ans += 1;
            }
        }

    }

    ans.writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;


void main() {
    auto s = readln.split.map!(to!long);
    auto A = s[0];
    auto B = s[1];

    long[] odd;
    long[] even;

    foreach (i; A..B+1) {
        if (i % 2 == 0) even ~= i;
        else odd ~= i;
    }

    int M = odd.length.to!int;
    long ans = 0;

    foreach (mask; 0..(1 << M)) {
        long[] hoge;
        foreach (i; 0..M) {
            if (mask & (1 << i)) {
                hoge ~= odd[i];
            }
        }

        bool ok = true;
        foreach (i; 0..hoge.length) {
            foreach (j; i+1..hoge.length) {
                if (gcd(hoge[i], hoge[j]) != 1) {
                    ok = false;
                    break;
                }
            }
        }

        if (!ok) {
            continue;
        }

        ans += 1;

        foreach (i; even) {
            if (hoge.length == 0 || hoge.map!(h => gcd(h, i) == 1).all) {
                ans += 1;
            }
        }

    }

    ans.writeln;
}
