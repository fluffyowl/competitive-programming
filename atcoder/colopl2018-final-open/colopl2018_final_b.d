import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.regex;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;
    auto stack = new int[](N+1);
    int sp = 0;
    dchar[] ans;

    foreach (s; S) {
        if (s == '+' || s == '-' || s == '*' || s == '/') {
            stack[sp++] = s;
        } else if (s == ',') {
            ans ~= stack[sp-1];
        } else if (s == ')') {
            sp--;
            ans ~= ')';
        } else {
            ans ~= s;
        }
    }

    ans.writeln;
}
