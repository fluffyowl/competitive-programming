import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

bool solve() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    A.sort();
    auto a_min = A[0];
    auto a_max = A[$-1];
    auto cnt = new int[](110);
    foreach (a; A) cnt[a] += 1; 

    if (N == 2) return a_min == 1 && a_max == 1;
    if (a_min != a_max/2 + a_max%2) return false;
    if (cnt[a_max] < 2) return false;

    if (a_max % 2 == 0 && cnt[a_min] != 1) return false;
    if (a_max % 2 == 1 && cnt[a_min] != 2) return false;

    foreach (i; a_min+1..a_max) {
        if (cnt[i] < 2) return false;
    }

    
    return true;
}

void main() {
    writeln(solve ? "Possible" : "Impossible");
}
