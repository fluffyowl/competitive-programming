import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto M = s[1];
    auto A = new int[](N);

    int i = 0;
    int sign = 1;
    int tmp = 0;
    int state = 0;

    void next() {
        i = ((i + sign) % N + N) % N;
    }

    while (true) {
        auto S = readln.chomp;
        if (state == 2 && S != "drawtwo") {
            A[i] += tmp;
            state = 0;
            tmp = 0;
            next;
        }
        if (state == 4 && S != "drawfour") {
            A[i] += tmp;
            state = 0;
            tmp = 0;
            next;
        }

        A[i] -= 1;
        M -= 1;

        if (M == 0) {
            writeln(i + 1, " ", -A[i]);
            return;
        }

        if (S == "number") {

        } else if (S == "drawtwo") {
            state = 2;
            tmp += 2;
        } else if (S == "drawfour") {
            state = 4;
            tmp += 4;
        } else if (S == "skip") {
            next;
        } else {
            sign *= -1;
        }

        next;
    }
}

