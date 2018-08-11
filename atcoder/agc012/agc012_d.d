import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10L^^9 + 7;

void main() {
    auto s = readln.split.map!(to!long);
    auto N = s[0].to!int;
    auto X = s[1];
    auto Y = s[2];
    auto A = new long[][](N);
    foreach (i; 0..N) {
        s = readln.split.map!(to!long);
        A[s[0].to!int-1] ~= s[1];
    }

    A = A.filter!(a => !a.empty).array;
    int M = A.length.to!int;
    
    foreach (i; 0..M) {
        A[i].sort!"a < b";
    }
    A.sort!"a[0] < b[0]";

    
    int[] B;
    
    foreach (i; 0..M) {
        if (i >= 1 && A[i][0] + A[0][0] > Y) {
            break;
        }
        
        int cnt = 1;
        long second = A.length > 1 ? A[1][0] : 1L<<59;
        
        foreach (j; 1..A[i].length) {
            if (i == 0) {
                if (A[i][0] + A[i][j] <= X || second + A[i][j] <= Y) {
                    ++cnt;
                }
            } else {
                if (A[i][0] + A[i][j] <= X || A[0][0] + A[i][j] <= Y) {
                    ++cnt;
                }
            }
        }
        B ~= cnt;
    }


    auto F = new long[](N+1);
    F[0] = 1;
    foreach (i; 0..N) {
        F[i+1] = F[i] * (i + 1) % MOD;
    }

    long ans = F[B.sum];
    foreach (b; B) {
        ans = ans * powmod(F[b], MOD-2, MOD) % MOD;
    }
    
    ans.writeln;;
}

long powmod(long a, long x, long m) {
    long ret = 1;
    while (x) {
        if (x % 2) ret = ret * a % m;
        a = a * a % m;
        x /= 2;
    }
    return ret;
}
