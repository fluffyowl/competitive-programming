import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = [0] ~ readln.split.map!(to!int).array ~ [0];

    foreach (x; 1..N+2) {
        auto used = new bool[](N+2);
        int[] stack = [0];
        bool ok = false;
        while (!stack.empty) {
            int n = stack.back;
            stack.popBack;
            if (n == N+1) {
                ok = true;
                break;
            }
            if (used[n]) continue;
            used[n] = true;
            foreach (i; 1..x+1) {
                if (n+i > N+1 || A[n+i] || used[n+i]) continue;
                stack ~= n+i;
            }
        }
        if (ok) {
            x.writeln;
            return;
        }
    }
}
