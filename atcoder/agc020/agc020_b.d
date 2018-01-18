import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;

    if (A[$-1] != 2) {
        writeln(-1);
        return;
    }

    auto B = new Tuple!(long, long)[](N);
    B[$-1] = tuple(2L, 3L);

    for (int i = N-2; i >= 0; --i) {
        long l = B[i+1][0];
        long r = B[i+1][1];
        long nl = l % A[i] == 0 ? l : (l / A[i] + 1) * A[i];
        long nr = r % A[i] == 0 ? r : (r / A[i]) * A[i];
        nr += A[i]-1;

        if (nl > r || nr < l) {
            writeln(-1);
            return;
        }
        B[i] = tuple(nl, nr);
    }

    writeln(B[0][0], " ", B[0][1]);
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;

    if (A[$-1] != 2) {
        writeln(-1);
        return;
    }

    auto B = new Tuple!(long, long)[](N);
    B[$-1] = tuple(2L, 3L);

    for (int i = N-2; i >= 0; --i) {
        long l = B[i+1][0];
        long r = B[i+1][1];
        long nl = l % A[i] == 0 ? l : (l / A[i] + 1) * A[i];
        long nr = r % A[i] == 0 ? r : (r / A[i]) * A[i];
        nr += A[i]-1;

        if (nl > r || nr < l) {
            writeln(-1);
            return;
        }
        B[i] = tuple(nl, nr);
    }

    writeln(B[0][0], " ", B[0][1]);
}
