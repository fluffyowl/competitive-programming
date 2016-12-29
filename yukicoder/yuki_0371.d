import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    immutable int p_max = 10^^5;
    bool[p_max] pt;
    long[] primes;
    
    foreach (i; 2..p_max) pt[i] = true;
    foreach (i; 2..p_max) {
        if (pt[i]) {
            primes ~= i;
            foreach (j; iota(i+i, p_max, i))
                pt[j] = false;
        }
    }
    primes.reverse;
    auto N = primes.length;

    long L, H;
    scanf("%lld %lld", &L, &H);

    foreach (i, p; enumerate(primes)) {
        if (p > H)
            continue;
        for (long j = H/p; (j>=p)&&(p*j>=L); j--) {
            bool flag = true;
            foreach (k; iota(N-1, i, -1)) {
                if (j % primes[k] == 0) {
                    flag = false;
                    break;
                }
            }
            if (flag) {
                writeln(p * j,  " ", );
                return;
            }
        }
    }
}

