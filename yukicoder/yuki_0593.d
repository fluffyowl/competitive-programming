import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    int three = 0;
    int five = 0;
    int p3 = 1;
    int p5 = 1;

    foreach (i; iota(N-1, -1, -1)) {
        int x3 = (S[i] - '0') * p3;
        (three += x3 % 3) %= 3;
        p3 = p3 * 4 % 3;

        int x5 = (S[i] - '0') * p5;
        (five += x5 % 5) %= 5;
        p5 = p5 * 4 % 5;
    }

    if (three == 0 && five == 0)
        writeln("FizzBuzz");
    else if (three == 0)
        writeln("Fizz");
    else if (five == 0)
        writeln("Buzz");
    else
        writeln(S);
}

