import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

int N;
int[] hoge;

int ask(int[] q) {
    debug {
        int ret = 0;
        foreach (i; 0..N)
            ret += q[i] * hoge[i];
        return ret;
    }
    writeln("? ", q.map!(a => a.to!string).join(" "));
    stdout.flush;
    return readln.chomp.to!int;
}

void main() {
    N = readln.chomp.to!int;
    debug {
        hoge = readln.split.map!(to!int).array;
    }

    auto ans = new int[](N);

    for (int i = 0; i < N; i += 5) {
        auto q = new int[](N);
        for (int j = 0; j < 5 && i + j < N; ++j) {
            q[i+j] = 10^^j;
        }
        auto ret = ask(q);

        for (int j = 0; j < 5 && i + j < N; ++j) {
            int m = ret % 10;
            ans[i+j] = m % 2;
            if (m <= 2) m += 10;
            ret -= m;
            ret /= 10;
        }
    }

    writeln("! ", ans.map!(a => a.to!string).join(" "));
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

int N;
int[] hoge;

int ask(int[] q) {
    debug {
        int ret = 0;
        foreach (i; 0..N)
            ret += q[i] * hoge[i];
        return ret;
    }
    writeln("? ", q.map!(a => a.to!string).join(" "));
    stdout.flush;
    return readln.chomp.to!int;
}

void main() {
    N = readln.chomp.to!int;
    debug {
        hoge = readln.split.map!(to!int).array;
    }

    auto ans = new int[](N);

    for (int i = 0; i < N; i += 5) {
        auto q = new int[](N);
        for (int j = 0; j < 5 && i + j < N; ++j) {
            q[i+j] = 10^^j;
        }
        auto ret = ask(q);

        for (int j = 0; j < 5 && i + j < N; ++j) {
            int m = ret % 10;
            ans[i+j] = m % 2;
            if (m <= 2) m += 10;
            ret -= m;
            ret /= 10;
        }
    }

    writeln("! ", ans.map!(a => a.to!string).join(" "));
}
