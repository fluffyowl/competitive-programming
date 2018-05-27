import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    auto K = readln.chomp.to!int;

    bool is_prime(int n) {
        for (int i = 2; i * i <= n; ++i)
            if (n % i == 0)
                return false;
        return true;
    }

    int f(int n) {
        int ret = 1;
        for (int i = 2; i * i <= n; ++i)
            if (n % i == 0)
                ret = i;
        return ret;
    }

    int f2(int n, int N) {
        int ret = 1;
        for (; ret* ret <= n && ret + ret <= N; ++ret) {}
        return ret-1;
    }

    int[] ans;
    int N = 250;

    int a = 2, b = 3;

    while (K > 0) {
        int x = f(K);
        int y = K / x;
        if (x + y <= N) {
            foreach (i; 0..x) ans ~= a;
            foreach (i; 0..y) ans ~= b;
            break;
        }

        x = f2(K, N);
        foreach (i; 0..x) ans ~= a;
        foreach (i; 0..x) ans ~= b;
        K -= x * x;
        N -= x + x;

        do {
            a = a * 3;
            b = a + 1;
        } while (!is_prime(a + b));
    }

    ans.length.writeln;
    ans.map!(to!string).join(" ").writeln;
}

