import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto s = readln.split.map!(to!int);
    auto K = s[0];
    auto N = s[1];

    if (N == 1) {
        writeln(K/2+K%2);
        return;
    }
    
    if (K % 2 == 0) {
        write(K/2, " ");
        foreach (i; 0..N-1) write(K, " ");
        writeln;
        return;
    }

    auto ans = new int[](N);
    ans.fill(K/2+1);
    int p = N-1;

    foreach (_; 0..N/2) {
        if (ans[p] == 1) {
            ans[p] = 0;
            p -= 1;
        } else {
            ans[p] = ans[p] - 1;
            p += 1;
            while (p < N) ans[p] = K, p += 1;
            p = N-1;
        }
    }

    ans.filter!(a => a!= 0).map!(to!string).join(" ").writeln;
}
