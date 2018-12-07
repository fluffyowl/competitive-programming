import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

int a;
int cnt = 0;
bool check = true;

int ask(long x) {
    debug {
        cnt += 1;
        if (x > 10^^9) check = false;
        writeln(x, " ", a % x, " ", a % x % 2);
        return (a % x) % 2;
    }
    writeln("? ", x);
    stdout.flush;
    return readln.chomp == "odd" ? 1 : 0;
}

void main() {
    debug {
        a = readln.chomp.to!int;
    }

    long ans = 0;
    int parity = ask(2);

    int hi = 10^^9/2;
    int lo = 0;
    while (hi - lo > 1) {
        int mid = (hi + lo) / 2 + (hi + lo) % 2;
        int num = mid * 2 + 1;
        if (ask(num) == parity) {
            hi = mid;
        } else {
            lo = mid;
        }
    }

    writeln("! ", lo*2+2-parity);

    debug {
        writeln(cnt, " ", check);
    }
}
