import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    auto s = readln.split;
    auto N = s[0].to!int;
    auto X = s[1].to!long;
    auto A = readln.split.map!(to!long).array;

    int[][long] dp1;
    int[][long] dp2;
    dp1[0] = [];
    dp2[0] = [];

    foreach (i; 0..N/2) {
        foreach (k; dp1.keys) {
            if (A[i]+k <= X && !(A[i]+k in dp1))
                dp1[A[i]+k] = (dp1[k] ~ i);
        }
        if (A[i] <= X && !(A[i] in dp1)) dp1[A[i]] = [i];
    }
    foreach (i; N/2..N) {
        foreach (k; dp2.keys) {
            if (A[i]+k <= X && !(A[i]+k in dp2))
                dp2[A[i]+k] = (dp2[k] ~ i);
        }
        if (A[i] <= X && !(A[i] in dp2)) dp2[A[i]] = [i];
    }

    string ans = "";
    foreach (k; dp1.keys) {
        if ((X-k) in dp2) {
            foreach (i; 0..N) {
                ans ~= (find(dp1[k], i).empty && find(dp2[X-k], i).empty) ? "x" : "o";
            }
            break;
        }
    }

    writeln(ans == "" ? "No" : ans);
}

