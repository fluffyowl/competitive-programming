import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

long N, cnt;

bool ask(long n) {
    writeln("? ", n);
    stdout.flush;
    cnt += 1;
    
    debug {
        string sn = n.to!string;
        string sN = N.to!string;
        return (n <= N && sn <= sN) || (n > N && sn > sN);
    } else {
        return readln.chomp == "Y";
    }
}

void main() {
    debug {N = readln.chomp.to!long;}

    long x = 10;
    for (; x <= 10^^9 && ask(x); x *= 10) {}

    if (x == 10L^^10) { // N = 1, 10, 100, ...
        x = 2;
        for (; x <= 2 * 10L^^9 && !ask(x); x *= 10) {}
        writeln("! ", x / 2);
    } else {
        long hi = x - 1;
        long lo = x / 10;
        while (hi - lo > 1) {
            long mid = (hi + lo) / 2;
            if (ask(mid * 10L^^9)) hi = mid;
            else lo = mid;
        }
        writeln("! ", hi);
    }

    debug {cnt.writeln;}
}
