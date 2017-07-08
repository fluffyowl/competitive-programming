import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

bool solve() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto d = A.reduce!max - A.reduce!min;
    if (d == 0) {
        if (A[0] == N - 1) return true;
        else if (A[0] <= N / 2) return true;
        else return false;
    } else if (d == 1) {
        auto a = A.reduce!max;
        auto b = A.reduce!min;
        int ca, cb;
        foreach (aa; A) {
            if (aa == a) ca += 1;
            else if (aa == b) cb += 1;
        }
        N = ca;
        a -= cb;
        if (a <= 0) return false;
        else if (a <= N / 2) return true;
        else return false;
    } else {
        return false;
    }

}

void main() {
    writeln(solve ? "Yes" : "No");
}
