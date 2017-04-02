import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    int N = readln.chomp.to!int;
    int zero = 'a' - 'a';
    int one = 'b' - 'a';
    int three = 'd' - 'a';
    int five = 'f' - 'a';
    for (int i = one; i < N+one; i++) {
        if (i % three == zero && i % five == zero) "FizzBuzz".writeln;
        else if (i % three == zero) "Fizz".writeln;
        else if (i % five  == zero) "Buzz".writeln;
        else i.writeln;
    }
}

