import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;

void main() {
    auto S = readln.chomp;
    auto s = readln.split.map!(to!int);
    auto X = s[0];
    auto Y = s[1];
    int tmp = 0;
    bool isX = true;
    int[] yoko;
    int[] tate;

    foreach (c; S) {
        if (c == 'F') {
            tmp += 1;
        } else if (isX) {
            yoko ~= tmp;
            isX ^= 1;
            tmp = 0;
        } else {
            tate ~= tmp;
            isX ^= 1;
            tmp = 0;
        }
    }

    if (isX) yoko ~= tmp;
    else tate ~= tmp;

    auto dpX = new bool[int][](yoko.length+1);
    dpX[0][0] = true;
    foreach (i; 0..yoko.length) {
        foreach (k; dpX[i].keys) {
            dpX[i+1][k + yoko[i]] = true;
            if (i > 0) dpX[i+1][k - yoko[i]] = true;;
        }
    }

    auto dpY = new bool[int][](tate.length+1);
    dpY[0][0] = true;
    foreach (i; 0..tate.length) {
        foreach (k; dpY[i].keys) {
            dpY[i+1][k + tate[i]] = true;
            dpY[i+1][k - tate[i]] = true;
        }
    }


    if (X in dpX[yoko.length] && Y in dpY[tate.length]) {
        writeln("Yes");
    } else {
        writeln("No");
    }
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;

void main() {
    auto S = readln.chomp;
    auto s = readln.split.map!(to!int);
    auto X = s[0];
    auto Y = s[1];
    int tmp = 0;
    bool isX = true;
    int[] yoko;
    int[] tate;

    foreach (c; S) {
        if (c == 'F') {
            tmp += 1;
        } else if (isX) {
            yoko ~= tmp;
            isX ^= 1;
            tmp = 0;
        } else {
            tate ~= tmp;
            isX ^= 1;
            tmp = 0;
        }
    }

    if (isX) yoko ~= tmp;
    else tate ~= tmp;

    auto dpX = new bool[int][](yoko.length+1);
    dpX[0][0] = true;
    foreach (i; 0..yoko.length) {
        foreach (k; dpX[i].keys) {
            dpX[i+1][k + yoko[i]] = true;
            if (i > 0) dpX[i+1][k - yoko[i]] = true;;
        }
    }

    auto dpY = new bool[int][](tate.length+1);
    dpY[0][0] = true;
    foreach (i; 0..tate.length) {
        foreach (k; dpY[i].keys) {
            dpY[i+1][k + tate[i]] = true;
            dpY[i+1][k - tate[i]] = true;
        }
    }


    if (X in dpX[yoko.length] && Y in dpY[tate.length]) {
        writeln("Yes");
    } else {
        writeln("No");
    }
}
