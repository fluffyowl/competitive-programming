import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    int p, a, b;
    auto N = readln.chomp.to!int;
    auto V = new real[][](3);
    immutable real EPS = 10.0L ^^ (-18);
    
    foreach (i; 0..N) {
        scanf("%d %d %d", &p, &a, &b);
        V[p] ~= 1.0L * b / (a + b);
    }

    long ans = N + 1;

    foreach (i; 0..3) {
        foreach (v1; V[i])
            foreach (v2; V[(i+1)%3])
                if (v1 + v2 < 1)
                    ans++;
    }

    auto W = V[2].sort().assumeSorted;
    int Wn = W.length.to!int;
    foreach (v1; V[0]) {
        foreach (v2; V[1]) {
            if (v1 + v2 > 1)
                continue;
            ans += Wn - W.upperBound(1-max(v1, v2)+EPS).length.to!int;
            ans -= Wn - W.lowerBound(1-v1-v2-EPS).length - W.upperBound(1-v1-v2+EPS).length;
        }
    }

    ans.writeln;
}

