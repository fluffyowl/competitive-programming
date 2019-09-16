import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto s = readln.split.map!(to!long);
    auto A = s[0];
    auto B = s[1];

    long ans =10L^^18 + 10;

    bool ok(long C) {
        return (A + B) % C == 0 && (B + C) % A == 0 && (C + A) % B == 0 && A != C && B != C;
    }

    for (long i = 1; i * i <= A + B; ++i) {
        if ((A + B) % i != 0) continue;
        if (ok(i)) ans = min(ans, i);
        if (ok(((A+B)/i))) ans = min(ans, (A+B)/i);
    }

    writeln(ans == 10L^^18 + 10 ? -1 : ans);
}
