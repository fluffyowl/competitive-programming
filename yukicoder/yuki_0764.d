import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

struct Circle {
    real x;
    real y;
    real r;
}

real intersection(Circle c1, Circle c2) {
    if (c1.r > c2.r) {
        swap(c1, c2);
    }

    real d = sqrt((c1.x - c2.x)^^2 + (c1.y - c2.y)^^2);

    if (d >= c1.r + c2.r) {
        return 0;
    }

    if (d <= c2.r-c1.r) {
        return c1.r * c1.r * PI;
    }

    real a1 = c1.r * c1.r * acos((d * d + c1.r * c1.r - c2.r * c2.r) / (2 * d * c1.r));
    real a2 = c2.r * c2.r * acos((d * d + c2.r * c2.r - c1.r * c1.r) / (2 * d * c2.r));
    real a3 = 0.5 * sqrt((-d + c1.r + c2.r) * (d + c1.r - c2.r) * (d - c1.r + c2.r) * (d + c1.r + c2.r));

    return a1 + a2 - a3;
}

real calc(Circle big1, Circle small1, Circle big2, Circle small2) {
    real a1 = intersection(big1, big2);
    real a2 = intersection(small1, big2);
    real a3 = intersection(small2, big1);
    real a4 = intersection(small1, small2);
    return (a1 - a2 - a3 + a4);
}

void main() {
    auto N = readln.chomp.to!int;
    auto P = readln.chomp.to!long;
    auto L = (N+1).iota.map!(_ => readln.chomp.to!long).array;

    foreach (i; 0..N) {
        auto s1 = L[0..i+1].sum;
        auto m1 = L[0..i+1].reduce!max;
        auto s2 = L[i+1..$].sum;
        auto m2 = L[i+1..$].reduce!max;
        auto big1 = Circle(0, 0, s1);
        auto small1 = Circle(0, 0, max(0, m1*2-s1));
        auto big2 = Circle(P, 0, s2);
        auto small2 = Circle(P, 0, max(0, m2*2-s2));
        writefln("%.9f", calc(big1, small1, big2, small2));
    }
}

