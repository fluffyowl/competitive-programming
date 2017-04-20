import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

immutable long MOD = 10^^9+7;

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;

    auto pow2 = new long[](N);
    pow2[0] = 1;
    foreach (i; 0..N-1) {
        pow2[i+1] = pow2[i] * 2 % MOD;
    }

    auto acm = new long[](N);
    acm[0] = A[0];
    foreach (i; 0..N-1) {
        acm[i+1] = (acm[i] * A[i+1]) % MOD;
    }

    
    long ans = 0;
    long tmp = 0;
    foreach (i; 0..N) {
        long tmptmp = acm[i];
        tmptmp = tmptmp * pow2[max(0, N-i-2)] % MOD;
        tmp += tmptmp;
        tmp %= MOD;
    }

    foreach (i; 0..N) {
        ans = (ans + tmp) % MOD;
        long hiku = A[i] * pow2[(max(0, N-i-2))+max(0, i-1)] % MOD; 
        tmp = (tmp - hiku) % MOD;
        tmp = (tmp + MOD) % MOD;
        tmp = tmp * powmod(A[i], MOD-2, MOD) % MOD;
        if (i >= 1) tmp = tmp * 2 % MOD;
        //writeln(ans, " ", tmp);
    }

    ans.writeln;
}
