import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;

    if (A.length == 3) {
        writeln("\"assert\"");
        return;
    }

    auto a = A.front;
    auto b = readln.chomp.to!long;
    auto c = readln.chomp.to!long;

    auto X = [a+b, b+c, c+a];
    X = X.sort!"a > b".uniq.array;

    writeln(X.length == 1 ? X.front : X[1]);
}
