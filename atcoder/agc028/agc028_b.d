import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;
long[] F;
long[] G;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;

    auto B = new long[](N+1);
    foreach (i; 0..N) B[i+1] = (B[i] + A[i]) % MOD;

    F = new long[](N+1);
    G = new long[](N+1);
    F[0] = G[0] = 1;
    foreach (i; 1..N+1) F[i] = F[i-1] * i % MOD;
    foreach (i; 1..N+1) G[i] = powmod(F[i], MOD-2, MOD);

    long ans = 0;
    long tmp = 0;
    foreach (i; 1..N-1) tmp = (tmp + A[i]) % MOD;
    int left = 1;
    int right = N-2;
    auto mem = new long[](N+2);
    int p = 1;

    foreach (len; 1..N+1) {
        mem[len] = tmp;
        if (len == N) {
            ans += B[N] * F[N] % MOD;
            ans %= MOD;
        } else if (len == N - 1) {
            ans += B[N-1] * F[N-1] % MOD;
            ans += (B[N] - B[1]) * F[N-1] % MOD;
            ans %= MOD;
        } else {
            auto comb1 = comb(N, len+1);
            auto tmptmp = comb1 * F[len] % MOD * F[N-len-1] % MOD;
            auto tmp1 = tmptmp * B[len] % MOD;
            auto tmp2 = tmptmp * ((B[N] - B[N-len]) % MOD) % MOD;
            auto tmp3 = comb(N, len+2) * 2 % MOD * F[len] % MOD * F[N-len-2] % MOD * tmp % MOD;
            ans += (tmp1 + tmp2 + tmp3) % MOD;
            ans %= MOD;
        }

        left += 1;
        right -= 1;
        if (left <= right) {
            tmp += B[right+1] - B[left];
            tmp %= MOD;
            if (left != right) p += 1;
        } else if (p >= 0) {
            tmp = mem[p];
            p -= 1;
        }
    }

    ans = (ans % MOD + MOD) % MOD;
    ans.writeln;
}


long comb(long n, long r) {
    return F[n] * G[n-r] % MOD * G[r] % MOD;
}

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = a * ret % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}
