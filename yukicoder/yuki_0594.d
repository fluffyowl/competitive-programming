import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

long ask(int[] xyz) {
    writeln("? ", xyz[0], " ", xyz[1], " ", xyz[2]);
    stdout.flush;
    return readln.chomp.to!long;
}

int search(int xyz) {
    long[int] d;
    int[] query = [-150, -150, -150];
    foreach (i; iota(-100, 101, 10)) {
        query[xyz] = i;
        d[i] = ask(query);
    }

    int mi = -1;
    long md = 1L << 59;
    foreach (k; d.keys) {
        if (d[k] < md) {
            mi = k;
            md = d[k];
        }
    }

    int mmi = -1;
    long mmd = 1L << 59;
    foreach (i; iota(-15, 15)) {
        query[xyz] = mi + i;
        long dd = ask(query);
        if (dd < mmd) {
            mmi = mi + i;
            mmd = dd;
        }
    }

    return mmi;
}


void main() {
    int x = search(0);
    int y = search(1);
    int z = search(2);
    writeln("! ", x, " " , y , " ", z);
}

