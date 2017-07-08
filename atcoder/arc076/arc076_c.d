import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;



bool solve() {
    auto s = readln.split.map!(to!int);
    auto C = s[0];
    auto R = s[1];
    auto N = s[2];

    Tuple!(int, int)[] points;

    foreach (i; 0..N) {
        s = readln.split.map!(to!int);
        int x1 = s[0];
        int y1 = s[1];
        int x2 = s[2];
        int y2 = s[3];

        if ((x1 == 0 || x1 == C || y1 == 0 || y1 == R) &&
            (x2 == 0 || x2 == C || y2 == 0 || y2 == R)) {
            if      (y1 == 0) points ~= tuple(x1, i);
            else if (x1 == C) points ~= tuple(C + y1, i);
            else if (y1 == R) points ~= tuple(C + R + (C - x1), i);
            else if (x1 == 0) points ~= tuple(C + R + C + (R - y1), i);
            if      (y2 == 0) points ~= tuple(x2, i);
            else if (x2 == C) points ~= tuple(C + y2, i);
            else if (y2 == R) points ~= tuple(C + R + (C - x2), i);
            else if (x2 == 0) points ~= tuple(C + R + C + (R - y2), i);
        }
    }

    points.sort();
    DList!int stack;

    foreach (p; points) {
        if (stack.empty) stack.insertBack(p[1]);
        else if (stack.back == p[1]) stack.removeBack;
        else stack.insertBack(p[1]);
    }

    return stack.empty;
}

void main() {
    writeln(solve ? "YES" : "NO");
}
