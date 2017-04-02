import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    auto B = A.dup.sort().uniq.array;

    int[int] compressor;
    foreach (i, e; enumerate(B)) {
        compressor[e] = i.to!int;
    }
    foreach (i; 0..N) {
        A[i] = compressor[A[i]];
    }
    auto M = B.length.to!int - 1;

    auto bit_left  = new BIT(M+1);
    auto bit_right = new BIT(M+1);
    auto bit_same  = new BIT(M+1);

    foreach (i; 1..N) {
        bit_right.add(A[i], 1);
    }

    long ans = 0;
    foreach (i; 1..N-1) {
        bit_right.add(A[i], -1);
        bit_left.add(A[i-1], 1);
        auto same = bit_same.sum(A[i-1], A[i-1]+1);
        bit_same.add(A[i-1], -same);
        bit_same.add(A[i-1], bit_left.sum(A[i-1], A[i-1]+1) * bit_right.sum(A[i-1], A[i-1]+1));
        
        if (A[i] > 0) {
            ans += bit_left.sum(0, A[i]) * bit_right.sum(0, A[i]) - bit_same.sum(0, A[i]);
        }
        if (A[i] < M) {
            ans += bit_left.sum(A[i]+1, M+1) * bit_right.sum(A[i]+1, M+1) - bit_same.sum(A[i]+1, M+1);
        }
    }
    
    ans.writeln;
}


class BIT {
    int N;
    long[] table;
    
    this(int n) {
        N = n;
        table = new long[](N);
        fill(table, 0);
    }
    
    // sum [0,i)
    long sum(int i){
        long ret = 0;
        for(--i; i>=0; i=(i&(i+1))-1) ret += table[i];
        return ret;
    }
    
    // sum [i,j)
    long sum(int i, int j) { return sum(j) - sum(i); }
    
    // add x to i
    void add(int i, long x) { for(; i < N; i|=i+1) table[i] += x; }
}

