import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;
     
void main() {
    immutable long MAX = 100;
    
    auto N = readln.chomp.replace(".", "").to!long;
    N /= 25;

    long[] f = [1, 1, 2, 6, 24, 120, 720];
    long ans = 0;
    long tmp;
    
    foreach (a; 0..MAX+1) {
        foreach (b; a..MAX+1) {
            foreach (c; b..MAX+1) {
                auto d = N - a - b - c;
                if (d < c || d > MAX) continue;
                long[long] count;
                count[a] += 1;
                count[b] += 1;
                count[c] += 1;
                count[d] += 1;
                
                // a, a, b, c, d, d
                tmp = f[6];
                count[a] += 1;
                count[d] += 1;
                foreach (i; count.values) tmp /= f[i.to!int];
                count[a] -= 1;
                count[d] -= 1;
                ans += tmp;

                // a未満, a, b, c, d, d
                tmp = f[6];
                count[d] += 1;
                foreach (i; count.values) tmp /= f[i.to!int];
                count[d] -= 1;
                ans += tmp * a;

                // a, a, b, c, d, dより大きい
                tmp = f[6];
                count[a] += 1;
                foreach (i; count.values) tmp /= f[i.to!int];
                count[a] -= 1;
                ans += tmp * (MAX-d);

                // a未満, a, b, c, d, dより大きい
                tmp = f[6];
                foreach (i; count.values) tmp /= f[i.to!int];
                ans += tmp * a * (MAX-d);
            }
        }
    }

    ans.writeln;
}

