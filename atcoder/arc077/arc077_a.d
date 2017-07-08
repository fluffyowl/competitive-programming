import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!int).array;
    DList!int queue;

    foreach (i; 0..N) {
        if (i % 2 == 0) queue.insertFront(A[i]);
        else            queue.insertBack(A[i]);
    }

    if (N % 2 == 0) foreach (i; 0..N) write(queue.back, " "),  queue.removeBack;
    else            foreach (i; 0..N) write(queue.front, " "), queue.removeFront;
    writeln;
}
