import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

real A, B, C;

real f(real t) {
    return A * t + B * sin(C * t * 3.14159265358979);
}

void main() {
    auto s = readln.split.map!(to!real);
    A = s[0];
    B = s[1];
    C = s[2];

    int n = 0;
    while (f(n) < 100) n += 1;


    real hi = n;
    real lo = n - 1;
    bool up = f(hi) > f(lo);
    foreach (_; 0..1000) {
        real mid = (hi + lo) / 2;
        if (f(mid) < 100 && up) lo = mid;
        else if (f(mid) < 100 && !up) hi = mid;
        else if (f(mid) >= 100 && up) hi = mid;
        else if (f(mid) >= 100 && !up) lo = mid;
    }

    writefln("%.15f", hi);
    //writefln("%.9f", f(hi));
}
