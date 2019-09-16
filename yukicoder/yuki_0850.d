import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

int ask(int a, int b) {
    writeln("? ", a + 1, " ", b + 1);
    stdout.flush;
    return readln.chomp.to!int - 1;
}

void main() {
    auto N = readln.chomp.to!int;

    auto losers = new int[][](N);
    int[] q1;
    int[] q2;
    foreach (i; 0..N) q1 ~= i;

    while (q1.length > 1) {
        q2 = [];
        for (int i = 0; i + 1 < q1.length; i += 2) {
            q2 ~= ask(q1[i], q1[i+1]);
            if (q2.back == q1[i]) {
                losers[q1[i]] ~= q1[i+1];
            } else {
                losers[q1[i+1]] ~= q1[i];
            }
        }
        if (q1.length % 2) {
            q2 ~= q1.back;
        }
        swap(q1, q2);
    }

    q1 = losers[q1.front].dup;
    q2 = [];

    while (q1.length > 1) {
        q2 = [];
        for (int i = 0; i + 1 < q1.length; i += 2) {
            q2 ~= ask(q1[i], q1[i+1]);
        }
        if (q1.length % 2) {
            q2 ~= q1.back;
        }
        swap(q1, q2);
    }

    writeln("! ", q1.front + 1);
}

