import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;

    int[long] rev;
    foreach (i; 0..N) rev[A[i]] = i;

    auto rbt = new RedBlackTree!(int)();
    rbt.insert(-1);
    rbt.insert(N);

    long ans = 0;
    foreach (a; 1..N+1) {
        auto i = rev[a.to!long];
        auto left  = i - rbt.lowerBound(i).back;
        auto right = rbt.upperBound(i).front - i;
        ans += 1L * right * left * a;
        rbt.insert(i);
    }

    ans.writeln;

}
