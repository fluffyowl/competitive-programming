import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

int calc(int a) {
    return (a + a + 1 + a + 2 + a + 7 + a + 8 + a + 9 + a + 14 + a + 15 + a + 16) % 11;
}

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto K = s[1];
    long ans = 0;

    if (N < 3) {
        writeln(-1);
        return;
    }

    if (N < 50) {
        for (int i = 0, a = 1; i < N - 2; ++i, a = (a + 7) % 11) 
            for (int j = a; j < a + 5; ++j) 
                ans += calc(j) == K;
        ans.writeln;
        return;
    }

    for (int i = 0, a = 1; i < 11; ++i, a = (a + 7) % 11) 
        for (int j = a; j < a + 5; ++j) 
            ans += calc(j) == K;
    
    ans *= (N - 2) / 11L;

    for (int i = 0, a = 1; i < (N - 2) % 11; ++i, a = (a + 7) % 11) 
        for (int j = a; j < a + 5; ++j) 
            ans += calc(j) == K;

    ans.writeln;
}
