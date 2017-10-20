import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

int[] Z_algorithm(string s) {
    auto A = new int[](s.length);
    A[0] = s.length.to!int;

    for (int i = 1, j = 0; i < s.length; ) {
        while (i + j < s.length && s[j] == s[i+j]) ++j;
        A[i] = j;
        if (j == 0) { ++i; continue; }
        int k = 1;
        while (i + k < s.length && k + A[k] < j) A[i+k] = A[k], ++k;
        i += k; j -= k;
    }

    return A;
}

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    if (all(S.map!(s => s == S[0]))) {
        writeln(N);
        writeln(1);
        return;
    }

    
    string T;
    foreach (i; 0..N) T ~= S[N - i - 1];
    
    auto z1 = Z_algorithm(S);
    auto z2 = Z_algorithm(T);
    auto ng1 = new bool[](N + 1);
    auto ng2 = new bool[](N + 1);

    for (int i = 0; i < N; i++) {
        if (i > 0 && i - z1[i] <= 0) {
            int len = min(i, z1[i]);
            int end = min(i + z1[i], N) + 1;
            for (int j = i + len; j < end && !ng1[j]; j += len) 
                ng1[j] = true;
        }
    }
    
    for (int i = 0; i < N; i++) {
        if (i > 0 && i - z2[i] <= 0) {
            int len = min(i, z2[i]);
            int end = min(i + z2[i], N) + 1;
            for (int j = i + len; j < end && !ng2[j]; j += len) 
                ng2[j] = true;
        }
    }


    ng2.reverse;
    auto ng = (N + 1).iota.map!(i => ng1[i] || ng2[i]);
    
    if (!ng[0]) {
        writeln(1);
        writeln(1);
    } else {
        writeln(2);
        writeln(N + 1 - ng.sum);
    }

    debug {
        z1.writeln;
        z2.writeln;
        ng1.map!(x => x ? 1: 0).writeln;
        ng2.map!(x => x ? 1: 0).writeln;
    }
}
