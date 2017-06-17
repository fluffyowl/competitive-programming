import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split.map!(to!int);
    auto P = s[0];
    auto Q = s[1];
    auto N = readln.chomp.to!int;
    if (P > Q) swap(P, Q);

    if (P == 0 && Q == 0) {
        int ans = 0;
        while (N--) {
            s = readln.split.map!(to!int);
            if (s[0] == 0 && s[1] == 0) ans++;
        }
        ans.writeln;
        return;
    } else if (P == 0) {
        int ans = 0;
        while (N--) {
            s = readln.split.map!(to!int);
            if (s[0] % Q == 0 && s[1] % Q == 0) ans ++;
        }
        ans.writeln;
        return;
    }
    
    auto G = gcd(P, Q);
    P /= G;
    Q /= G;
    
    int ans = 0;
    
    while (N--) {
        s = readln.split.map!(to!int);
        auto x = s[0];
        auto y = s[1];
        if (x % G != 0 || y % G != 0) continue;
        x /= G;
        y /= G;
        if (P % 2 == 0 || Q % 2 == 0 || (x + y) % 2 == 0) ans += 1;
    }

    ans.writeln;
}

