import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;

    auto ans = new int[](N);
    int[] stack;

    foreach (i; 0..N) {
        if (S[i] == '(')
            stack ~= i;
        else {
            ans[i] = stack.back + 1;
            ans[stack.back] = i + 1;
            stack.popBack;
        }
    }

    ans.each!writeln;
}

