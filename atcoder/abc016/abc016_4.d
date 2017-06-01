import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!long);
    auto ax = s[0];
    auto ay = s[1];
    auto bx = s[2];
    auto by = s[3];
    auto N = readln.chomp.to!int;
    auto XY = N.iota.map!(_ => readln.split.map!(to!long).array).array;

    int cnt = 0;

    foreach (i; 0..N) {
        auto cx = XY[i][0];
        auto cy = XY[i][1];
        auto dx = XY[(i+1)%N][0];
        auto dy = XY[(i+1)%N][1];

        auto ta = (cx - dx) * (ay - cy) + (cy - dy) * (cx - ax);
        auto tb = (cx - dx) * (by - cy) + (cy - dy) * (cx - bx);
        auto tc = (ax - bx) * (cy - ay) + (ay - by) * (ax - cx);
        auto td = (ax - bx) * (dy - ay) + (ay - by) * (ax - dx);

        if (tc * td < 0 && ta * tb < 0)
            cnt++;
    }

    writeln(1 + cnt/2);
}
