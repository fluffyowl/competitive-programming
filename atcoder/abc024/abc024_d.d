import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable long MOD = 10^^9+7;

long pow(long a, long x) {
    a %= MOD;
    long ret = 1;
    while (x > 0) {
        if (x % 2 == 1)
            ret = ret * a % MOD;
        a = a * a % MOD;
        x /= 2;
    }
    return ret;
}

void main() {
    long A = readln.chomp.to!int;
    long C = readln.chomp.to!int;
    long B = readln.chomp.to!int;
    long x = (-A*B + B*C) % MOD * pow(A*B - B*C + A*C, MOD-2) % MOD;
    long y = (-A*x - A + B*x + B) % MOD * pow(A, MOD-2) % MOD;
    writeln((x+MOD)%MOD, " ", (y+MOD)%MOD);
}
